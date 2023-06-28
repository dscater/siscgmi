<?php

namespace App\Http\Controllers;

use App\Models\Indicador;
use Illuminate\Http\Request;

class IndicadorController extends Controller
{
    public function getNro(Request $request)
    {
        $tipo = $request->tipo;
        $ultimo_registro = Indicador::where("tipo", $tipo)->orderBy("id")->get()->last();
        $nro = 1;
        if ($ultimo_registro) {
            $nro = (int)$ultimo_registro->nro + 1;
        }
        return response()->JSON($nro);
    }
    public function getMTFB(Request $request)
    {
        $tipo = $request->tipo;
        $anio = $request->anio;
        $mes = $request->mes;
        $nro = $request->nro;
        $equipo_id = $request->equipo_id;

        $existe = Indicador::where("tipo", "MTBF")->orderBy("id")->get()->first();
        if ($existe) {
            $existe->nro = (int)$nro;
            $existe->save();
        } else {
            Indicador::create([
                "tipo" => "MTBF",
                "nro" => $nro
            ]);
        }

        return $request;
    }
    public function getMTTR(Request $request)
    {
        $tipo = $request->tipo;
        $anio = $request->anio;
        $mes = $request->mes;
        $equipo_id = $request->equipo_id;
    }
    public function getDisponibilidad(Request $request)
    {
        $tipo = $request->tipo;
        $anio = $request->anio;
        $mes = $request->mes;
        $equipo_id = $request->equipo_id;
    }
}
