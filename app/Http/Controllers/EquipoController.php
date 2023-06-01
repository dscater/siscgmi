<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use App\Models\HistorialAccion;
use App\Models\Maquinaria;
use App\Models\Subunidad;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EquipoController extends Controller
{
    public $validacion = [
        "area_id" => "required",
        "sistema_id" => "required",
        'codigo' => 'required|min:4|max:4|unique:equipos,codigo',
        'nombre' => 'required|min:2',
        'numero' => 'required|numeric|digits_between:2, 2',
        'codigo2' => 'required|unique:equipos,codigo2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $equipos = Equipo::with("area")->with("sistema")->get();
        return response()->JSON(['equipos' => $equipos, 'total' => count($equipos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Equipo
            $nuevo_equipo = Equipo::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_equipo, "equipos");
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
                'equipo' => $nuevo_equipo,
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

    public function update(Request $request, Equipo $equipo)
    {
        $this->validacion['codigo'] = 'required|min:4|max:4|unique:equipos,codigo,' . $equipo->id;
        $this->validacion['codigo2'] = 'required|unique:equipos,codigo2,' . $equipo->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($equipo, "equipos");
            $equipo->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($equipo, "equipos");
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
                'equipo' => $equipo,
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

    public function show(Equipo $equipo)
    {
        return response()->JSON([
            'sw' => true,
            'equipo' => $equipo
        ], 200);
    }

    public function destroy(Equipo $equipo)
    {
        DB::beginTransaction();
        try {
            $existe = Subunidad::where("equipo_id", $equipo->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }
            $existe = Maquinaria::where("equipo_id", $equipo->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $datos_original = HistorialAccion::getDetalleRegistro($equipo, "equipos");
            $equipo->delete();
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
