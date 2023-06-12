<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Personal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PersonalController extends Controller
{
    public $validacion = [
        "tipo_mo" => "required",
        'razon_social' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $personals = Personal::with("user")->get();
        return response()->JSON(['personals' => $personals, 'total' => count($personals)], 200);
    }

    public function store(Request $request)
    {
        if ($request->tipo_mo == 'USUARIOS') {
            $this->validacion["user_id"] = "required|unique:personals,user_id";
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Personal
            $nuevo_personal = Personal::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_personal, "personals");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PERSONAL',
                'datos_original' => $datos_original,
                'modulo' => 'PERSONAL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'personal' => $nuevo_personal,
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

    public function update(Request $request, Personal $personal)
    {
        if ($request->tipo_mo == 'USUARIOS') {
            $this->validacion["user_id"] = "required|unique:personals,user_id," . $personal->id;
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($personal, "personals");
            $personal->update(array_map('mb_strtoupper', $request->all()));
            if ($request->tipo_mo != 'USUARIOS') {
                $personal["user_id"] = null;
                $personal->save();
            }
            $datos_nuevo = HistorialAccion::getDetalleRegistro($personal, "personals");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PERSONAL',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PERSONAL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'personal' => $personal,
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

    public function show(Personal $personal)
    {
        return response()->JSON([
            'sw' => true,
            'personal' => $personal
        ], 200);
    }

    public function destroy(Personal $personal)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($personal, "personals");
            $personal->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PERSONAL',
                'datos_original' => $datos_original,
                'modulo' => 'PERSONAL',
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
