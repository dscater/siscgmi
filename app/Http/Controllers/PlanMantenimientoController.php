<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PlanMantenimientoController extends Controller
{
    public $validacion = [
        "codificacion" => "required",
        "subunidad_id" => "required",
        "gama_id" => "required",
        "pm" => "required",
        "prioridad" => "required",
        "tiempo" => "required",
        "tipo_mantenimiento" => "required",
        "programacion" => "required",
        "fecha_final" => "required|date",
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $plan_mantenimientos = PlanMantenimiento::with(["programacions", "subunidad", "gama", "variable_control", "frecuencia"])->get();
        return response()->JSON(['plan_mantenimientos' => $plan_mantenimientos, 'total' => count($plan_mantenimientos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear PlanMantenimiento
            $request["stock_actual"] = 0;
            $nueva_plan_mantenimiento = PlanMantenimiento::create(array_map('mb_strtoupper', $request->except("foto")));
            $nueva_plan_mantenimiento->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_plan_mantenimiento, "plan_mantenimientos");
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
                'plan_mantenimiento' => $nueva_plan_mantenimiento,
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

    public function update(Request $request, PlanMantenimiento $plan_mantenimiento)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
            $plan_mantenimiento->update(array_map('mb_strtoupper', $request->except("foto")));
            $plan_mantenimiento->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
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
                'plan_mantenimiento' => $plan_mantenimiento,
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

    public function show(PlanMantenimiento $plan_mantenimiento)
    {
        return response()->JSON([
            'sw' => true,
            'plan_mantenimiento' => $plan_mantenimiento
        ], 200);
    }

    public function destroy(PlanMantenimiento $plan_mantenimiento)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
            $plan_mantenimiento->delete();
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
