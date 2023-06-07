<?php

namespace App\Http\Controllers;

use App\Models\EntradaRepuesto;
use App\Models\HistorialAccion;
use App\Models\KardexRepuesto;
use App\Models\Repuesto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EntradaRepuestoController extends Controller
{
    public $validacion = [
        'repuesto_id' => 'required',
        'cantidad' => 'required|numeric|min:1',
        'precio' => 'required|numeric|min:1',
        'total' => 'required|numeric|min:1',
        'fecha' => 'required|date',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $entrada_repuestos = EntradaRepuesto::with("repuesto")->get();
        return response()->JSON(['entrada_repuestos' => $entrada_repuestos, 'total' => count($entrada_repuestos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear EntradaRepuesto
            $nueva_entrada_repuesto = EntradaRepuesto::create(array_map('mb_strtoupper', $request->all()));

            // registrar kardex
            KardexRepuesto::registroIngreso("ENTRADA", $nueva_entrada_repuesto->id, $nueva_entrada_repuesto->repuesto, $nueva_entrada_repuesto->cantidad, $nueva_entrada_repuesto->precio, $nueva_entrada_repuesto->descripcion);

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_entrada_repuesto, "entrada_repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA ENTRADA DE REPUESTOS/INSUMOS',
                'datos_original' => $datos_original,
                'modulo' => 'ENTRADA DE REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'entrada_repuesto' => $nueva_entrada_repuesto,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, EntradaRepuesto $entrada_repuesto)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // descontar el stock
            Repuesto::decrementarStock($entrada_repuesto->repuesto, $entrada_repuesto->cantidad);

            $datos_original = HistorialAccion::getDetalleRegistro($entrada_repuesto, "entrada_repuestos");
            $entrada_repuesto->update(array_map('mb_strtoupper', $request->all()));

            // INCREMENTAR STOCK
            Repuesto::incrementarStock($entrada_repuesto->repuesto, $entrada_repuesto->cantidad);

            // actualizar kardex
            $kardex = KardexRepuesto::where("repuesto_id", $entrada_repuesto->repuesto_id)
                ->where("tipo_registro", "ENTRADA")
                ->where("registro_id", $entrada_repuesto->id)
                ->get()->first();
            KardexRepuesto::actualizaRegistrosKardex($kardex->id, $kardex->repuesto_id);

            $datos_nueva = HistorialAccion::getDetalleRegistro($entrada_repuesto, "entrada_repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA ENTRADA DE REPUESTOS/INSUMOS',
                'datos_original' => $datos_original,
                'datos_nueva' => $datos_nueva,
                'modulo' => 'ENTRADA DE REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'entrada_repuesto' => $entrada_repuesto,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(EntradaRepuesto $entrada_repuesto)
    {
        return response()->JSON([
            'sw' => true,
            'entrada_repuesto' => $entrada_repuesto
        ], 200);
    }

    public function destroy(EntradaRepuesto $entrada_repuesto)
    {
        DB::beginTransaction();
        try {
            $eliminar_kardex = KardexRepuesto::where("tipo_registro", "ENTRADA")
                ->where("registro_id", $entrada_repuesto->id)
                ->where("repuesto_id", $entrada_repuesto->repuesto_id)
                ->get()
                ->first();
            $id_kardex = $eliminar_kardex->id;
            $id_repuesto = $eliminar_kardex->repuesto_id;
            $eliminar_kardex->delete();

            $anterior = KardexRepuesto::where("repuesto_id", $id_repuesto)
                ->where("id", "<", $id_kardex)
                ->get()
                ->last();
            $actualiza_desde = null;
            if ($anterior) {
                $actualiza_desde = $anterior;
            } else {
                // comprobar si existen registros posteriorres al actualizado
                $siguiente = KardexRepuesto::where("repuesto_id", $id_repuesto)
                    ->where("id", ">", $id_kardex)
                    ->get()->first();
                if ($siguiente)
                    $actualiza_desde = $siguiente;
            }

            if ($actualiza_desde) {
                // actualizar a partir de este registro los sgtes. registros
                KardexRepuesto::actualizaRegistrosKardex($actualiza_desde->id, $actualiza_desde->repuesto_id);
            }
            // descontar el stock
            Repuesto::decrementarStock($entrada_repuesto->repuesto, $entrada_repuesto->cantidad);

            $datos_original = HistorialAccion::getDetalleRegistro($entrada_repuesto, "entrada_repuestos");
            $entrada_repuesto->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA ENTRADA DE REPUESTOS/INSUMOS',
                'datos_original' => $datos_original,
                'modulo' => 'ENTRADA DE REPUESTOS/INSUMOS',
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
