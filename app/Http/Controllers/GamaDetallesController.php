<?php

namespace App\Http\Controllers;

use App\Models\GamaDetalles;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class GamaDetallesController extends Controller
{
    public function cambiaEstado(GamaDetalles $gama_detalle, Request $request)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($gama_detalle, "gama_detalles");

            $gama_detalle->update($request->all());

            $datos_nuevo = HistorialAccion::getDetalleRegistro($gama_detalle, "gama_detalles");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA TAREA DE MANTENIMIENTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'GAMA DE MANTENIMIENTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Registro actualizado",
                "item" => $gama_detalle
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
