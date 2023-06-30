<?php

namespace App\Http\Controllers;

use App\Models\EntradaRepuesto;
use App\Models\HistorialAccion;
use App\Models\ModeloDeterministico;
use App\Models\Repuesto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ModeloDeterministicoController extends Controller
{
    public $validacion = [
        'codigo' => 'required|min:2|unique:modelo_deterministicos,codigo',
        'nombre' => 'required|min:2',
        'repuesto_id' => 'required',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $modelo_deterministicos = ModeloDeterministico::with("repuesto")->get();
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
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN MODELO DETERMINISTICO',
                'datos_original' => $datos_original,
                'modulo' => 'MODELOS DETERMINISTICOS',
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
        $this->validacion['codigo'] = 'required|min:2|unique:modelo_deterministicos,codigo,' . $modelo_deterministico->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($modelo_deterministico, "modelo_deterministicos");
            $modelo_deterministico->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($modelo_deterministico, "modelo_deterministicos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN MODELO DETERMINISTICO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'MODELOS DETERMINISTICOS',
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
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN MODELO DETERMINISTICO',
                'datos_original' => $datos_original,
                'modulo' => 'MODELOS DETERMINISTICOS',
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

    public function getPromedioRepuestos(Request $request)
    {
        $repuesto_id = $request->repuesto_id;
        // $repuestos = Repuesto::select("id")->where("repuesto_id", $repuesto_id)->get();
        $repuestos = Repuesto::select("id")->get();
        $suma_total = Repuesto::sum("precio");
        $valor_promedio = number_format((float)$suma_total / (float)count($repuestos), 2, '.', '');
        $suma_cantidad = EntradaRepuesto::sum("cantidad");
        $cantidad_promedio = number_format((float)$suma_cantidad / (float)count($repuestos), 2, '.', '');

        $costo_promedio = number_format((float)$valor_promedio / (float)$cantidad_promedio, 2, '.', '');
        return response()->JSON([
            "valor_promedio" => $valor_promedio,
            "cantidad_promedio" => $cantidad_promedio,
            "costo_promedio" => $costo_promedio,
        ]);
    }
}
