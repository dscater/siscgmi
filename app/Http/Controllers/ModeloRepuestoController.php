<?php

namespace App\Http\Controllers;

use App\Models\KardexRepuesto;
use App\Models\ModeloRepuesto;
use Illuminate\Http\Request;

class ModeloRepuestoController extends Controller
{
    public function getModeloRepuesto(Request $request)
    {
        $repuesto_id = $request->repuesto_id;
        $anio_ini = $request->anio_ini;
        $trimestre_ini = $request->trimestre_ini;
        $anio_fin = $request->anio_fin;
        $trimestre_fin = $request->trimestre_fin;
        $modelo_repuesto = ModeloRepuesto::where("repuesto_id", $repuesto_id)->get()->first();
        if (!$modelo_repuesto) {
            $modelo_repuesto = ModeloRepuesto::create([
                "repuesto_id" => $repuesto_id,
                "anio_ini" => $anio_ini,
                "trimestre_ini" => $trimestre_ini,
                "anio_fin" => $anio_fin,
                "trimestre_fin" => $trimestre_fin,
                "demanda" => 0,
            ]);
        }

        // meses por trimestre
        $meses_trimestres = [
            1 => [1, 2, 3],
            2 => [4, 5, 6],
            3 => [7, 8, 9],
            4 => [10, 11, 12],
        ];

        // recorrer los anios y trimestres
        $aux_ini = $anio_ini;
        $contador_trimestre = 1; // X
        $suma_trimestres = 0; // SUMA X
        $suma_y = 0;
        $suma_x2 = 0;
        $suma_y2 = 0;
        $suma_xy = 0;

        while ($aux_ini <= $anio_fin) {
            $aux_ini_tri = $trimestre_ini;
            $ultimo_trimestre = 4;
            if ($aux_ini == $anio_fin) {
                $ultimo_trimestre = $trimestre_fin;
            }
            while ($aux_ini_tri <= $ultimo_trimestre) {
                $anio = $aux_ini;
                $meses = $meses_trimestres[$aux_ini_tri];
                // buscar la cantidad de salidas por el anio y mes
                foreach ($meses as $mes) {
                    $anio_mes = $anio . '-' . ($mes < 10 ? '0' . $mes : $mes);
                    $cantidad_salidas = KardexRepuesto::where("tipo_is", "EGRESO")
                        ->where("repuesto_id", $repuesto_id)
                        ->where("fecha", "LIKE", "$anio_mes%")
                        ->sum("cantidad_salida");
                    // x^2
                    $y = $cantidad_salidas;
                    $x2 = pow($contador_trimestre, 2);
                    $y2 = pow($y, 2);
                    $xy = $contador_trimestre * $y;

                    $suma_y += $y;
                    $suma_x2 += $x2;
                    $suma_y2 += $y2;
                    $suma_xy += $xy;
                }
                $aux_ini_tri++;
                // incrementar nro. trimestre
                $suma_trimestres += $contador_trimestre;
                $contador_trimestre++;
            }
            $aux_ini++;
        }

        // obtener b
        $n = $contador_trimestre - 1;
        $b = ($n * $suma_xy - ($suma_trimestres - $suma_y)) / ($n * $suma_x2) - pow($suma_trimestres, 2);

        // obtener a
        $a = ($suma_y - ($b * $suma_trimestres)) / $n;

        // obtener la demanda Y
        $demanda = $a + $b * $contador_trimestre;

        $modelo_repuesto->update([
            "demanda" => number_format($demanda, 2, '.', ''),
        ]);
        return response()->json([
            "sw" => true,
            "modelo_repuesto" => $modelo_repuesto
        ]);
    }
}
