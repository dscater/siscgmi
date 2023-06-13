<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\SubFamilia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SubFamiliaController extends Controller
{
    public $validacion = [
        "familia_id" => "required",
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $sub_familias = SubFamilia::with("familia")->get();
        return response()->JSON(['sub_familias' => $sub_familias, 'total' => count($sub_familias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear SubFamilia
            $nuevo_sub_familia = SubFamilia::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_sub_familia, "sub_familias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA SUBFAMILIA',
                'datos_original' => $datos_original,
                'modulo' => 'SUBFAMILIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'sub_familia' => $nuevo_sub_familia,
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

    public function update(Request $request, SubFamilia $sub_familia)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($sub_familia, "sub_familias");
            $sub_familia->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($sub_familia, "sub_familias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA SUBFAMILIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SUBFAMILIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'sub_familia' => $sub_familia,
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

    public function show(SubFamilia $sub_familia)
    {
        return response()->JSON([
            'sw' => true,
            'sub_familia' => $sub_familia
        ], 200);
    }

    public function destroy(SubFamilia $sub_familia)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($sub_familia, "sub_familias");
            $sub_familia->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA SUBFAMILIA',
                'datos_original' => $datos_original,
                'modulo' => 'SUBFAMILIAS',
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
