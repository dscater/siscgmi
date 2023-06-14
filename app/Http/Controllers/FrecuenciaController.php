<?php

namespace App\Http\Controllers;

use App\Models\Frecuencia;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FrecuenciaController extends Controller
{
    public $validacion = [
        'variable_id' => 'required',
        'frecuencia' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $frecuencias = Frecuencia::with("variable")->get();
        return response()->JSON(['frecuencias' => $frecuencias, 'total' => count($frecuencias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Frecuencia
            $nuevo_frecuencia = Frecuencia::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_frecuencia, "frecuencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA CATEGORIA',
                'datos_original' => $datos_original,
                'modulo' => 'CATEGORIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'frecuencia' => $nuevo_frecuencia,
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

    public function update(Request $request, Frecuencia $frecuencia)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($frecuencia, "frecuencias");
            $frecuencia->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($frecuencia, "frecuencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA CATEGORIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CATEGORIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'frecuencia' => $frecuencia,
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

    public function show(Frecuencia $frecuencia)
    {
        return response()->JSON([
            'sw' => true,
            'frecuencia' => $frecuencia
        ], 200);
    }

    public function getByVariableControl(Request $request)
    {
        $id = $request->id;
        $frecuencias = Frecuencia::where("variable_id", $id)->get();
        return response()->JSON($frecuencias);
    }

    public function destroy(Frecuencia $frecuencia)
    {
        DB::beginTransaction();
        try {
            // $existe = Producto::where("frecuencia_id", $frecuencia->id)->get();
            // if (count($existe) > 0) {
            //     throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            // }

            $datos_original = HistorialAccion::getDetalleRegistro($frecuencia, "frecuencias");
            $frecuencia->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA CATEGORIA',
                'datos_original' => $datos_original,
                'modulo' => 'CATEGORIAS',
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
