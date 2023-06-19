<?php

namespace App\Http\Controllers;

use App\Models\DetalleHerramienta;
use App\Models\HistorialAccion;
use App\Models\OrdenGenerada;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DetalleHerramientaController extends Controller
{
    public function store(OrdenGenerada $orden_generada, Request $request)
    {
        DB::beginTransaction();
        try {
            $eliminados = $request->eliminados;
            $detalle_herramientas = $request->detalle_herramientas;
            if (isset($eliminados) && count($eliminados) > 0) {
                foreach ($eliminados as $e) {
                    $dr = DetalleHerramienta::find($e);
                    $datos_original = HistorialAccion::getDetalleRegistro($dr, "detalle_herramientas");
                    $dr->delete();
                    HistorialAccion::create([
                        'user_id' => Auth::user()->id,
                        'accion' => 'ELIMINACIÓN',
                        'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA HERRAMIENTA EN UNA GENERACIÓN DE OT',
                        'datos_original' => $datos_original,
                        'modulo' => 'GENERACIÓN DE OT - HERRAMIENTAS',
                        'fecha' => date('Y-m-d'),
                        'hora' => date('H:i:s')
                    ]);
                }
            }
            if (isset($detalle_herramientas) && count($detalle_herramientas) > 0) {
                foreach ($detalle_herramientas as $dr) {
                    if ($dr["id"] == 0) {
                        unset($dr["id"]);
                        unset($dr["orden_generada_id"]);
                        $dr_encontrado = $orden_generada->detalle_herramientas()->create($dr);
                        $datos_original = HistorialAccion::getDetalleRegistro($dr_encontrado, "detalle_herramientas");
                        HistorialAccion::create([
                            'user_id' => Auth::user()->id,
                            'accion' => 'REGISTRO',
                            'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA HERRAMIENTA EN UNA GENERACIÓN DE OT',
                            'datos_original' => $datos_original,
                            'modulo' => 'GENERACIÓN DE OT - HERRAMIENTAS',
                            'fecha' => date('Y-m-d'),
                            'hora' => date('H:i:s')
                        ]);
                    } else {
                        $dr_encontrado = DetalleHerramienta::find($dr["id"]);
                        unset($dr["orden_generada_id"]);
                        $dr_encontrado->update($dr);
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
