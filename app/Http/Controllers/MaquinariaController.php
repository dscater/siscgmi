<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Maquinaria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class MaquinariaController extends Controller
{
    public $validacion = [
        "equipo_id" => "required",
        "descripcion" => "required",
        "prioridad" => "required",
        "ubicacion" => "required",
        "tipo" => "required",
        "estado" => "required"
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $maquinarias = Maquinaria::with("equipo")->get();
        return response()->JSON(['maquinarias' => $maquinarias, 'total' => count($maquinarias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Maquinaria
            $nuevo_maquinaria = Maquinaria::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_maquinaria, "maquinarias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN SISTEMA',
                'datos_original' => $datos_original,
                'modulo' => 'SISTEMAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'maquinaria' => $nuevo_maquinaria,
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

    public function update(Request $request, Maquinaria $maquinaria)
    {
        $this->validacion['codigo'] = 'required|min:4|max:4|unique:maquinarias,codigo,' . $maquinaria->id;
        $this->validacion['codigo2'] = 'required|unique:maquinarias,codigo2,' . $maquinaria->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
            $maquinaria->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN SISTEMA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SISTEMAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'maquinaria' => $maquinaria,
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

    public function show(Maquinaria $maquinaria)
    {
        return response()->JSON([
            'sw' => true,
            'maquinaria' => $maquinaria
        ], 200);
    }

    public function destroy(Maquinaria $maquinaria)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
            $maquinaria->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN SISTEMA',
                'datos_original' => $datos_original,
                'modulo' => 'SISTEMAS',
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
