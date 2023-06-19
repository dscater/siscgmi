<?php

namespace App\Http\Controllers;

use App\Models\DetallePersonal;
use App\Models\HistorialAccion;
use App\Models\Notificacion;
use App\Models\OrdenGenerada;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DetallePersonalController extends Controller
{
    public function store(OrdenGenerada $orden_generada, Request $request)
    {
        DB::beginTransaction();
        try {
            $eliminados = $request->eliminados;
            $detalle_personals = $request->detalle_personals;
            if (isset($eliminados) && count($eliminados) > 0) {
                foreach ($eliminados as $e) {
                    $dr = DetallePersonal::find($e);
                    $datos_original = HistorialAccion::getDetalleRegistro($dr, "detalle_personals");
                    HistorialAccion::create([
                        'user_id' => Auth::user()->id,
                        'accion' => 'ELIMINACIÓN',
                        'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PERSONAL EN UNA GENERACIÓN DE OT',
                        'datos_original' => $datos_original,
                        'modulo' => 'GENERACIÓN DE OT - PERSONAL',
                        'fecha' => date('Y-m-d'),
                        'hora' => date('H:i:s')
                    ]);
                    $dr->delete();
                }
            }
            if (isset($detalle_personals) && count($detalle_personals) > 0) {
                $nueva_notificacion = Notificacion::create([
                    "notificacion" => "ASIGNACIÓN DE ORDEN DE TRABAJO",
                    "registro_id" => $orden_generada->id,
                    "tipo" => "GENERACIÓN DE OT"
                ]);
                foreach ($detalle_personals as $dr) {
                    if ($dr["id"] == 0) {
                        unset($dr["id"]);
                        unset($dr["orden_generada_id"]);
                        $dr_encontrado = $orden_generada->detalle_personals()->create($dr);
                        $datos_original = HistorialAccion::getDetalleRegistro($dr_encontrado, "detalle_personals");
                        HistorialAccion::create([
                            'user_id' => Auth::user()->id,
                            'accion' => 'REGISTRO',
                            'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PERSONAL EN UNA GENERACIÓN DE OT',
                            'datos_original' => $datos_original,
                            'modulo' => 'GENERACIÓN DE OT - PERSONAL',
                            'fecha' => date('Y-m-d'),
                            'hora' => date('H:i:s')
                        ]);
                    } else {
                        $dr_encontrado = DetallePersonal::find($dr["id"]);
                        unset($dr["orden_generada_id"]);
                        $dr_encontrado->update($dr);
                    }
                    // REGISTRAR NOTIFICACIÓN
                    if ($dr_encontrado->personal->tipo_mo == 'USUARIOS') {
                        $usuario = User::find($dr_encontrado->personal->user_id);
                        $usuario->notificacions_user()->create([
                            "notificacion_id" => $nueva_notificacion->id,
                            "visto" => 0
                        ]);
                    } else {
                        $usuarios = User::where("tipo", "JEFE DE MANTENIMIENTO")->get();
                        foreach ($usuarios as $usuario) {
                            $usuario->notificacions_user()->create([
                                "notificacion_id" => $nueva_notificacion->id,
                                "visto" => 0
                            ]);
                        }
                    }
                }
            }
            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Registro(s) guardados correctamente",
                "orden_generada" => $orden_generada->load([
                    "detalle_repuestos.repuesto", "detalle_herramientas.herramienta", "detalle_personals.personal",
                ])
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "sw" => false,
                "message" => $e->getMessage(),
                "orden_generada" => $orden_generada->load([
                    "detalle_repuestos.repuesto", "detalle_herramientas.herramienta", "detalle_personals.personal",
                ])
            ], 500);
        }
    }
}
