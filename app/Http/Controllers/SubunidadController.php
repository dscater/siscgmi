<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Subunidad;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SubunidadController extends Controller
{
    public $validacion = [
        "area_id" => "required",
        "sistema_id" => "required",
        "equipo_id" => "required",
        'codigo' => 'required|min:4|max:4|unique:subunidads,codigo',
        'nombre' => 'required|min:2',
        'numero' => 'required|numeric|digits_between:2, 2',
        'codigo2' => 'required|unique:subunidads,codigo2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $subunidads = Subunidad::with("area")->with("sistema")->with("equipo")->get();
        return response()->JSON(['subunidads' => $subunidads, 'total' => count($subunidads)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Subunidad
            $nuevo_subunidad = Subunidad::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_subunidad, "subunidads");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA SUBUNIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'SUBUNIDADES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'subunidad' => $nuevo_subunidad,
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

    public function update(Request $request, Subunidad $subunidad)
    {
        $this->validacion['codigo'] = 'required|min:4|max:4|unique:subunidads,codigo,' . $subunidad->id;
        $this->validacion['codigo2'] = 'required|unique:subunidads,codigo2,' . $subunidad->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($subunidad, "subunidads");
            $subunidad->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($subunidad, "subunidads");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA SUBUNIDAD',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SUBUNIDADES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'subunidad' => $subunidad,
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

    public function show(Subunidad $subunidad)
    {
        return response()->JSON([
            'sw' => true,
            'subunidad' => $subunidad
        ], 200);
    }

    public function destroy(Subunidad $subunidad)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($subunidad, "subunidads");
            $subunidad->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA SUBUNIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'SUBUNIDADES',
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
