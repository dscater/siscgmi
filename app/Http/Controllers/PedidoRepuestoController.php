<?php

namespace App\Http\Controllers;

use App\Models\DetallePedido;
use App\Models\HistorialAccion;
use App\Models\Notificacion;
use App\Models\PedidoRepuesto;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PedidoRepuestoController extends Controller
{
    public $validacion = [
        'orden_id' => 'required',
        'detalle_repuestos' => 'required|array|min:1',
        'detalle_repuestos.*.cantidad_requerida' => 'required|numeric|min:1',
    ];

    public $mensajes = [
        "orden_id.required" => "Debes seleccionar una orden de trabajo",
        "detalle_repuestos.required" => "El registro que seleccionaste no cuenta con un listado de repuestos",
        "detalle_repuestos.min" => "La lista de repuestos debe ser al menos de :min",
        'detalle_repuestos.*.cantidad_requerida.required' => 'Debes indicar una cantidad requerida',
        'detalle_repuestos.*.cantidad_requerida.min' => 'La cantidad solicitada debe ser al menos :min',
        'detalle_repuestos.*.cantidad_requerida.numeric' => 'La cantidad solicitada debe ser de formato númerico',
    ];

    public function index(Request $request)
    {
        $pedido_repuestos = PedidoRepuesto::with(["orden_trabajo", "detalle_pedidos.repuesto"])->get();
        return response()->JSON(['pedido_repuestos' => $pedido_repuestos, 'total' => count($pedido_repuestos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear PedidoRepuesto
            $nuevo_pedido_repuesto = PedidoRepuesto::create(array_map('mb_strtoupper', $request->except("detalle_repuestos")));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_pedido_repuesto, "pedido_repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PEDIDO DE REPUESTO',
                'datos_original' => $datos_original,
                'modulo' => 'PEDIDO DE REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            // registrar solicitud detalle
            $detalle_repuestos = $request->detalle_repuestos;
            foreach ($detalle_repuestos as $dr) {
                $nuevo_pedido_repuesto->detalle_pedidos()->create([
                    "repuesto_id" => $dr["repuesto_id"],
                    "cantidad_requerida" => $dr["cantidad_requerida"],
                ]);
            }

            // notificacion usuarios
            $nueva_notificacion = Notificacion::create([
                "notificacion" => "ORDEN DE PEDIDO DE REPUESTO",
                "registro_id" => $nuevo_pedido_repuesto->id,
                "tipo" => "PEDIDO DE REPUESTO"
            ]);
            $usuarios = User::where("tipo", "SUPERVISOR DE COMPRAS")->get();
            foreach ($usuarios as $usuario) {
                $usuario->notificacions_user()->create([
                    "notificacion_id" => $nueva_notificacion->id,
                    "visto" => 0
                ]);
            }

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'pedido_repuesto' => $nuevo_pedido_repuesto,
                'message' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, PedidoRepuesto $pedido_repuesto)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($pedido_repuesto, "pedido_repuestos");
            $pedido_repuesto->update(array_map('mb_strtoupper', $request->except("detalle_repuestos")));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($pedido_repuesto, "pedido_repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PEDIDO DE REPUESTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PEDIDO DE REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            // registrar solicitud detalle
            $detalle_repuestos = $request->detalle_repuestos;
            foreach ($detalle_repuestos as $dr) {
                $detalle_pedido = DetallePedido::find($dr["id"]);
                $detalle_pedido->update([
                    "cantidad_requerida" => $dr["cantidad_requerida"],
                ]);
            }

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'pedido_repuesto' => $pedido_repuesto,
                'message' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(PedidoRepuesto $pedido_repuesto)
    {
        return response()->JSON([
            'sw' => true,
            'pedido_repuesto' => $pedido_repuesto
        ], 200);
    }

    public function destroy(PedidoRepuesto $pedido_repuesto)
    {
        DB::beginTransaction();
        try {
            $notificacion = Notificacion::where("registro_id", $pedido_repuesto->id)->where("tipo", "PEDIDO DE REPUESTO")->get()->first();
            if ($notificacion) {
                $notificacion->notificacion_users()->delete();
                $notificacion->delete();
            }
            $pedido_repuesto->detalle_pedidos()->delete();
            $datos_original = HistorialAccion::getDetalleRegistro($pedido_repuesto, "pedido_repuestos");
            $pedido_repuesto->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PEDIDO DE REPUESTO',
                'datos_original' => $datos_original,
                'modulo' => 'PEDIDO DE REPUESTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
