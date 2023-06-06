<?php

namespace App\Http\Controllers;

use App\Models\Frecuencia;
use App\Models\HistorialAccion;
use App\Models\VariableControl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class VariableControlController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
        'unidad' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $variable_controls = VariableControl::all();
        return response()->JSON(['variable_controls' => $variable_controls, 'total' => count($variable_controls)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear VariableControl
            $nueva_variable_control = VariableControl::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_variable_control, "variable_controls");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA VARIABLE DE CONTROL',
                'datos_original' => $datos_original,
                'modulo' => 'VARIABLES DE CONTROL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'variable_control' => $nueva_variable_control,
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

    public function update(Request $request, VariableControl $variable_control)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($variable_control, "variable_controls");
            $variable_control->update(array_map('mb_strtoupper', $request->all()));

            $datos_nueva = HistorialAccion::getDetalleRegistro($variable_control, "variable_controls");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA VARIABLE DE CONTROL',
                'datos_original' => $datos_original,
                'datos_nueva' => $datos_nueva,
                'modulo' => 'VARIABLES DE CONTROL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'variable_control' => $variable_control,
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

    public function show(VariableControl $variable_control)
    {
        return response()->JSON([
            'sw' => true,
            'variable_control' => $variable_control
        ], 200);
    }

    public function destroy(VariableControl $variable_control)
    {
        DB::beginTransaction();
        try {
            $existe = Frecuencia::where("variable_id", $variable_control->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $datos_original = HistorialAccion::getDetalleRegistro($variable_control, "variable_controls");
            $variable_control->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA VARIABLE DE CONTROL',
                'datos_original' => $datos_original,
                'modulo' => 'VARIABLES DE CONTROL',
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
