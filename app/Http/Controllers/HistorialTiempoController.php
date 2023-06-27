<?php

namespace App\Http\Controllers;

use App\Models\DetalleTiempo;
use App\Models\HistorialAccion;
use App\Models\HistorialTiempo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class HistorialTiempoController extends Controller
{
    public $validacion = [
        'codificacion' => 'required|min:2|unique:historial_tiempos,codificacion',
        'anio' => 'required',
        'mes' => 'required',
        'equipo_id' => 'required',
        'detalle_tiempos' => 'required|array|min:1',
        'detalle_tiempos.*.fecha' => 'required|date',
        'detalle_tiempos.*.tiempo' => 'required|numeric|min:0',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $historial_tiempos = HistorialTiempo::all();
        return response()->JSON(['historial_tiempos' => $historial_tiempos, 'total' => count($historial_tiempos)], 200);
    }

    public function verifica_registro(Request $request)
    {
        $anio = $request->anio;
        $mes = $request->mes;
        $equipo_id = $request->equipo_id;

        $existe = HistorialTiempo::where("anio", $anio)->where("mes", $mes)->where("equipo_id", $equipo_id)->get()->first();

        if ($existe) {
            return response()->JSON([
                "existe" => true,
                "historial_tiempo" => $existe->load("detalle_tiempos"),
            ]);
        }

        $detalle_tiempos = HistorialTiempo::getDetalleTiempos($anio, $mes);
        return response()->JSON([
            "existe" => false,
            "detalle_tiempos" => $detalle_tiempos,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear HistorialTiempo
            $nuevo_historial_tiempo = HistorialTiempo::create(array_map('mb_strtoupper', $request->except("detalle_tiempos")));
            $nuevo_historial_tiempo->detalle_tiempos()->createMany($request->detalle_tiempos);
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_historial_tiempo, "historial_tiempos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN HISTORIAL DE TIEMPO',
                'datos_original' => $datos_original,
                'modulo' => 'HISTORIAL DE TIEMPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'historial_tiempo' => $nuevo_historial_tiempo->load("detalle_tiempos"),
                'message' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, HistorialTiempo $historial_tiempo)
    {
        $this->validacion['codificacion'] = 'required|min:2|unique:historial_tiempos,codificacion,' . $historial_tiempo->id;
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($historial_tiempo, "historial_tiempos");
            $historial_tiempo->update(array_map('mb_strtoupper', $request->except("detalle_tiempos")));

            foreach ($request->detalle_tiempos as $registro) {
                $reg_actualiza = DetalleTiempo::find($registro["id"]);
                $reg_actualiza->update(array_map("mb_strtoupper", $registro));
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($historial_tiempo, "historial_tiempos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN HISTORIAL DE TIEMPO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'HISTORIAL DE TIEMPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'historial_tiempo' => $historial_tiempo->load("detalle_tiempos"),
                'message' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(HistorialTiempo $historial_tiempo)
    {
        return response()->JSON([
            'sw' => true,
            'historial_tiempo' => $historial_tiempo->load("detalle_tiempos")
        ], 200);
    }

    public function destroy(HistorialTiempo $historial_tiempo)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($historial_tiempo, "historial_tiempos");
            $historial_tiempo->detalle_tiempos()->delete();
            $historial_tiempo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN HISTORIAL DE TIEMPO',
                'datos_original' => $datos_original,
                'modulo' => 'HISTORIAL DE TIEMPOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
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
