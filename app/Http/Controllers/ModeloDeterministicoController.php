<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\ModeloDeterministico;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ModeloDeterministicoController extends Controller
{
    public $validacion = [
        'codigo' => 'required|min:2|max:2|unique:modelo_deterministicos,codigo',
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $modelo_deterministicos = ModeloDeterministico::all();
        return response()->JSON(['modelo_deterministicos' => $modelo_deterministicos, 'total' => count($modelo_deterministicos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear ModeloDeterministico
            $nuevo_modelo_deterministico = ModeloDeterministico::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_modelo_deterministico, "modelo_deterministicos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN AREA',
                'datos_original' => $datos_original,
                'modulo' => 'AREAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'modelo_deterministico' => $nuevo_modelo_deterministico,
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

    public function update(Request $request, ModeloDeterministico $modelo_deterministico)
    {
        $this->validacion['codigo'] = 'required|min:2|max:2|unique:modelo_deterministicos,codigo,' . $modelo_deterministico->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($modelo_deterministico, "modelo_deterministicos");
            $modelo_deterministico->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($modelo_deterministico, "modelo_deterministicos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN AREA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'AREAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'modelo_deterministico' => $modelo_deterministico,
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

    public function show(ModeloDeterministico $modelo_deterministico)
    {
        return response()->JSON([
            'sw' => true,
            'modelo_deterministico' => $modelo_deterministico
        ], 200);
    }

    public function destroy(ModeloDeterministico $modelo_deterministico)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($modelo_deterministico, "modelo_deterministicos");
            $modelo_deterministico->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN AREA',
                'datos_original' => $datos_original,
                'modulo' => 'AREAS',
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
