<?php

namespace App\Http\Controllers;

use App\Models\DetalleRepuesto;
use App\Models\HistorialAccion;
use App\Models\KardexRepuesto;
use App\Models\OrdenGenerada;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DetalleRepuestoController extends Controller
{
    public function store(OrdenGenerada $orden_generada, Request $request)
    {
        DB::beginTransaction();
        try {
            $eliminados = $request->eliminados;
            $detalle_repuestos = $request->detalle_repuestos;
            if (isset($eliminados) && count($eliminados) > 0) {
                foreach ($eliminados as $e) {
                    $dr = DetalleRepuesto::find($e);
                    $datos_original = HistorialAccion::getDetalleRegistro($dr, "detalle_repuestos");
                    $dr->delete();
                    HistorialAccion::create([
                        'user_id' => Auth::user()->id,
                        'accion' => 'ELIMINACIÓN',
                        'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN REPUESTO EN UNA GENERACIÓN DE OT',
                        'datos_original' => $datos_original,
                        'modulo' => 'GENERACIÓN DE OT - REPUESTOS',
                        'fecha' => date('Y-m-d'),
                        'hora' => date('H:i:s')
                    ]);
                }
            }
            if (isset($detalle_repuestos) && count($detalle_repuestos) > 0) {
                foreach ($detalle_repuestos as $dr) {
                    if ($dr["id"] == 0) {
                        unset($dr["id"]);
                        unset($dr["orden_generada_id"]);
                        $dr_encontrado = $orden_generada->detalle_repuestos()->create($dr);
                        $datos_original = HistorialAccion::getDetalleRegistro($dr_encontrado, "detalle_repuestos");
                        HistorialAccion::create([
                            'user_id' => Auth::user()->id,
                            'accion' => 'REGISTRO',
                            'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN REPUESTO EN UNA GENERACIÓN DE OT',
                            'datos_original' => $datos_original,
                            'modulo' => 'GENERACIÓN DE OT - REPUESTOS',
                            'fecha' => date('Y-m-d'),
                            'hora' => date('H:i:s')
                        ]);
                    } else {
                        $dr_encontrado = DetalleRepuesto::find($dr["id"]);
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

    public function cambiaEstado(DetalleRepuesto $detalle_repuesto, Request $request)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($detalle_repuesto, "detalle_repuestos");
            $detalle_repuesto->update($request->all());

            if ($detalle_repuesto->chekado == 1) {
                // registrar kardex egreso
                KardexRepuesto::registroEgreso("DETALLE REPUESTO", $detalle_repuesto->id, $detalle_repuesto->repuesto, $detalle_repuesto->cantidad_requerida, $detalle_repuesto->costo, "ASIGNACIÓN DE REPUESTO DESDE VISUALIZACIÓN DE OT");
            } else {
                // registrar kardex ingreso
                KardexRepuesto::registroIngreso("DETALLE REPUESTO", $detalle_repuesto->id, $detalle_repuesto->repuesto, $detalle_repuesto->cantidad_requerida, $detalle_repuesto->costo, "NEGAR ASIGNACIÓN DE REPUESTO DESDE VISUALIZACIÓN DE OT");
            }
            $datos_nuevo = HistorialAccion::getDetalleRegistro($detalle_repuesto, "detalle_repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN REPUESTO DE UNA ORDEN GENERADA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDEN GENERADA',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Registro actualizado",
                "item" => $detalle_repuesto->load("repuesto")
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "sw" => false,
                "message" => $e->getMessage(),
            ], 500);
        }
    }
}
