<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Notificacion;
use App\Models\OrdenTrabajo;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OrdenTrabajoController extends Controller
{
    public $validacion = [
        'fecha_programada' => 'required|date',
        'subunidad_id' => 'required',
        'gama_id' => 'required',
        'prioridad' => 'required',
        'tiempo' => 'required',
        'tipo_mantenimiento' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $orden_trabajos = OrdenTrabajo::with("subunidad")->with("gama")->get();
        return response()->JSON(['orden_trabajos' => $orden_trabajos, 'total' => count($orden_trabajos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear OrdenTrabajo
            $request["estado"] = "PROGRAMADO";
            $nuevo_orden_trabajo = OrdenTrabajo::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_orden_trabajo, "orden_trabajos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA ORDEN DE TRABAJO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDENES DE TRABAJO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'orden_trabajo' => $nuevo_orden_trabajo,
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

    public function update(Request $request, OrdenTrabajo $orden_trabajo)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            $orden_trabajo->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA ORDEN DE TRABAJO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDENES DE TRABAJO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'orden_trabajo' => $orden_trabajo,
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

    public function show(OrdenTrabajo $orden_trabajo)
    {
        // verifica fecha limite
        $fecha_fin = $orden_trabajo->gama->plan_mantenimiento->fecha_final;
        if (date("Y-m-d") > date("Y-m-d", strtotime($fecha_fin))) {
            if ($orden_trabajo->estado == 'PROGRAMADO' && $orden_trabajo->estado != 'CANCELADO') {
                $orden_trabajo->update(["estado" => "PENDIENTE"]);
            }
        }

        return response()->JSON([
            'sw' => true,
            'orden_trabajo' => $orden_trabajo->load(["gama.equipo", "gama.plan_mantenimiento", "gama.gama_detalles", "subunidad.equipo", "subunidad.area", "subunidad.sistema", "orden_generada.detalle_repuestos.repuesto", "orden_generada.detalle_herramientas.herramienta", "orden_generada.detalle_personals.personal"])
        ], 200);
    }

    public function getWithOrdenGenerada(OrdenTrabajo $orden_trabajo)
    {
        return response()->JSON([
            'sw' => true,
            'orden_trabajo' => $orden_trabajo->load([
                "orden_generada.detalle_repuestos.repuesto", "orden_generada.detalle_herramientas.herramienta", "orden_generada.detalle_personals.personal",
            ])
        ], 200);
    }

    public function destroy(OrdenTrabajo $orden_trabajo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            $orden_trabajo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA ORDEN DE TRABAJO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDENES DE TRABAJO',
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

    public function programados_fecha(Request $request)
    {
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $orden_trabajos = OrdenTrabajo::with(["subunidad.equipo", "gama.equipo", "orden_generada.detalle_repuestos", "orden_generada.detalle_herramientas", "orden_generada.detalle_personals"])
            ->where("estado", "PROGRAMADO")->get();
        if ($fecha_ini && $fecha_ini != "" && $fecha_fin && $fecha_fin != "") {
            $orden_trabajos = OrdenTrabajo::with(["subunidad.equipo", "gama.equipo", "orden_generada.detalle_repuestos", "orden_generada.detalle_herramientas", "orden_generada.detalle_personals"])
                ->whereBetween("fecha_programada", [$fecha_ini, $fecha_fin])
                ->orWhere("estado", "PROGRAMADO")->get();
        }

        return response()->JSON($orden_trabajos);
    }

    public function registraNuevoEstado(OrdenTrabajo $orden_trabajo, Request $request)
    {
        $request->validate([
            "estado" => "required",
            "razon" => "required|min:4",
        ]);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            $orden_trabajo->update(array_map("mb_strtoupper", $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ACTUALIZÓ EL ESTADO DE UNA ORDEN DE TRABAJO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDENES DE TRABAJO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            $nueva_notificacion = Notificacion::create([
                "notificacion" => "CAMBIO DE ESTADO OT: " . $orden_trabajo->id,
                "registro_id" => $orden_trabajo->id,
                "tipo" => "CAMBIO DE ESTADO OT"
            ]);

            $usuarios = User::where("tipo", "JEFE DE MANTENIMIENTO")->get();
            foreach ($usuarios as $usuario) {
                $usuario->notificacions_user()->create([
                    "notificacion_id" => $nueva_notificacion->id,
                    "visto" => 0
                ]);
            }

            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Estado actualizado con éxito"
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    public function registraTerminarOT(OrdenTrabajo $orden_trabajo, Request $request)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            $orden_trabajo->update(array_map("mb_strtoupper", $request->only(["estado", "comentario", "razon", "fecha_termino", "hora_termino"])));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($orden_trabajo, "orden_trabajos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' TERMINÓ UNA ORDEN DE TRABAJO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDENES DE TRABAJO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Estado actualizado con éxito"
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
