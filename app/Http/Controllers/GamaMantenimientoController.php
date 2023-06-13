<?php

namespace App\Http\Controllers;

use App\Models\GamaDetalles;
use App\Models\GamaMantenimiento;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class GamaMantenimientoController extends Controller
{
    public $validacion = [
        "codigo" => "required",
        "subfamilia_id" => "required",
        "equipo_id" => "required",
        "gama_detalles" => "required|array|min:1",
        "gama_detalles.*.tarea" => "required|min:1",
        "gama_detalles.*.tiempo" => "required|numeric",
    ];

    public $mensajes = [
        "gama_detalles.*.tarea.required" => "Debes indicar una tarea",
        "gama_detalles.*.tiempo.required" => "Debes indicar un tiempo",
    ];

    public function index(Request $request)
    {
        $gama_mantenimientos = GamaMantenimiento::with("subfamilia")->with("equipo")->with("gama_detalles")->get();
        return response()->JSON(['gama_mantenimientos' => $gama_mantenimientos, 'total' => count($gama_mantenimientos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear GamaMantenimiento
            $nueva_gama_mantenimiento = GamaMantenimiento::create(array_map('mb_strtoupper', $request->except("gama_detalles")));
            $gama_detalles = $request->gama_detalles;
            foreach ($gama_detalles as $gd) {
                $nueva_gama_mantenimiento->gama_detalles()->create([
                    "tarea" => mb_strtoupper($gd["tarea"]),
                    "tiempo" => $gd["tiempo"],
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_gama_mantenimiento, "gama_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'gama_mantenimiento' => $nueva_gama_mantenimiento,
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

    public function update(Request $request, GamaMantenimiento $gama_mantenimiento)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($gama_mantenimiento, "gama_mantenimientos");
            $gama_mantenimiento->update(array_map('mb_strtoupper', $request->except("gama_detalles", "eliminados")));
            if (isset($request->eliminados) && count($request->eliminados) > 0) {
                $eliminados = $request->eliminados;
                foreach ($eliminados as $e) {
                    $o_gd = GamaDetalles::find($e);
                    $o_gd->delete();
                }
            }
            $gama_detalles = $request->gama_detalles;
            foreach ($gama_detalles as $gd) {
                if ($gd["id"] == 0) {
                    $gama_mantenimiento->gama_detalles()->create([
                        "tarea" => mb_strtoupper($gd["tarea"]),
                        "tiempo" => $gd["tiempo"],
                    ]);
                } else {
                    $o_gd = GamaDetalles::find($gd["id"]);
                    $o_gd->update([
                        "tarea" => mb_strtoupper($gd["tarea"]),
                        "tiempo" => mb_strtoupper($gd["tiempo"]),
                    ]);
                }
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($gama_mantenimiento, "gama_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'gama_mantenimiento' => $gama_mantenimiento,
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

    public function show(GamaMantenimiento $gama_mantenimiento)
    {
        return response()->JSON([
            'sw' => true,
            'gama_mantenimiento' => $gama_mantenimiento->load("gama_detalles")
        ], 200);
    }

    public function destroy(GamaMantenimiento $gama_mantenimiento)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($gama_mantenimiento, "gama_mantenimientos");
            $gama_mantenimiento->gama_detalles()->delete();
            $gama_mantenimiento->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
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
