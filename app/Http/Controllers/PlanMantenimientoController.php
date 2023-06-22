<?php

namespace App\Http\Controllers;

use App\Models\Frecuencia;
use App\Models\HistorialAccion;
use App\Models\PlanMantenimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PlanMantenimientoController extends Controller
{
    public $validacion = [
        "codificacion" => "required",
        "subunidad_id" => "required",
        'gama_id' => 'required|unique:plan_mantenimientos,gama_id',
        "pm" => "required",
        "prioridad" => "required",
        "tiempo" => "required",
        "tipo_mantenimiento" => "required",
        "programacion" => "required",
        "fecha_final" => "required|date",
        "programacions" => "required|array|min:1"
    ];

    public $mensajes = [
        "programacions.required" => "No se generó la programación respectiva",
        "programacions.min" => "Debe existir al menos :min generación",
        'gama_id.unique' => 'La gama de mantenimiento ya cuenta con un plan de mantenimiento',
    ];

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
            $request["estado"] = "PLANIFICADO";
            $nueva_plan_mantenimiento = PlanMantenimiento::create(array_map('mb_strtoupper', $request->except("programacions")));
            $nueva_plan_mantenimiento->programacions()->createMany($request->programacions);

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_plan_mantenimiento, "plan_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PLAN DE MANTENIMIENTO',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE MANTENIMIENTO',
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
        $this->validacion['gama_id'] = 'required|unique:plan_mantenimientos,gama_id,' . $plan_mantenimiento->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
            $plan_mantenimiento->update(array_map('mb_strtoupper', $request->except("programacions")));
            $plan_mantenimiento->programacions()->delete();
            $plan_mantenimiento->programacions()->createMany($request->programacions);
            $datos_nuevo = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PLAN DE MANTENIMIENTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PLAN DE MANTENIMIENTO',
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
            'plan_mantenimiento' => $plan_mantenimiento->load("programacions")
        ], 200);
    }

    public function destroy(PlanMantenimiento $plan_mantenimiento)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_mantenimiento, "plan_mantenimientos");
            $plan_mantenimiento->programacions()->delete();
            $plan_mantenimiento->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PLAN DE MANTENIMIENTO',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE MANTENIMIENTO',
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

    public function getPlanProgramacion(Request $request)
    {
        $frecuencia_id = $request->frecuencia_id;
        $frecuencia = Frecuencia::find($frecuencia_id)->frecuencia;
        $fecha_recibida = $request->fecha_recibida;
        $fecha_final = $request->fecha_final;

        $fecha_inicio = date("Y-m-d", strtotime($fecha_recibida . '-1 days'));
        $programacions = [];
        $contador = 1;
        $fecha_inicio = date("Y-m-d", strtotime($fecha_inicio . "+$frecuencia days"));
        while ($fecha_inicio <= date("Y-m-d", strtotime($fecha_final))) {
            $fecha = $fecha_inicio;
            $programacions[] = [
                "id" => 0,
                "numero" => $contador++,
                "dias" => $frecuencia,
                "fecha" => $fecha,
            ];
            $fecha_inicio = date("Y-m-d", strtotime($fecha_inicio . "+$frecuencia days"));
        }
        return response()->JSON($programacions);
    }
}
