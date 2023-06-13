<?php

namespace App\Http\Controllers;

use App\Models\Familia;
use App\Models\GamaMantenimiento;
use App\Models\HistorialAccion;
use App\Models\SubFamilia;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FamiliaController extends Controller
{
    public $validacion = [
        'codigo' => 'required|unique:familias,codigo',
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $familias = Familia::all();
        return response()->JSON(['familias' => $familias, 'total' => count($familias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Familia
            $nuevo_familia = Familia::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_familia, "familias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA FAMILIA',
                'datos_original' => $datos_original,
                'modulo' => 'FAMILIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'familia' => $nuevo_familia,
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

    public function update(Request $request, Familia $familia)
    {
        $this->validacion['codigo'] = 'required|unique:familias,codigo,' . $familia->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($familia, "familias");
            $familia->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($familia, "familias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA FAMILIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'FAMILIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'familia' => $familia,
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

    public function show(Familia $familia)
    {
        return response()->JSON([
            'sw' => true,
            'familia' => $familia
        ], 200);
    }

    public function destroy(Familia $familia)
    {
        DB::beginTransaction();
        try {
            $existe = SubFamilia::where("familia_id", $familia->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }
            $existe = GamaMantenimiento::where("familia_id", $familia->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $datos_original = HistorialAccion::getDetalleRegistro($familia, "familias");
            $familia->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA FAMILIA',
                'datos_original' => $datos_original,
                'modulo' => 'FAMILIAS',
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
