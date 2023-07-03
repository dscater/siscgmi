<?php

namespace App\Http\Controllers;

use App\Models\HistorialFalla;
use App\Models\HistorialTiempo;
use App\Models\Indicador;
use DateInterval;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

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
        $anio = $request->anio;
        $mes = $request->mes;
        $nro = $request->nro;
        $equipo_id = $request->equipo_id;

        $meses = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];

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

        $tiempo_disponible_total = 0;
        $tiempo_muerto_total = 0;
        $numero_fallas_total = 0;
        $mtbf = [];

        // armar fecha_filtro
        $fecha_filtro = $anio . "-" . ($mes < 10 ? '0' . $mes : $mes);
        $registro_final = HistorialFalla::where("fecha_falla", "LIKE", "$fecha_filtro%")->get()->last();
        Log::debug($fecha_filtro);
        $registro_inicial = HistorialFalla::where("fecha_falla", "<=", $registro_final->fecha_falla)->get()->first();

        $anios_meses = IndicadorController::obtenerAnioMesesEntreFechas($registro_inicial->fecha_falla, $registro_final->fecha_falla);

        foreach ($anios_meses as $am) {
            $anio = date("Y", strtotime($am));
            $mes = date("m", strtotime($am));
            // tiempo_disponible
            $tiempo_disponible = 0;
            $existe_historial_tiempo = HistorialTiempo::where("anio", "=", $anio)
                ->where("mes", "=", $mes)
                ->where("equipo_id", $equipo_id)
                ->get()->first();
            if ($existe_historial_tiempo) {
                $tiempo_disponible = $existe_historial_tiempo->total_tiempo;
            } else {
                $existe_historial_tiempo = HistorialTiempo::where("anio", "<=", $anio)
                    ->where("mes", "<=", $mes)
                    ->where("equipo_id", $equipo_id)
                    ->orderBy("anio", "asc")
                    ->orderBy("mes", "asc")->get()->last();
                if ($existe_historial_tiempo) {
                    $tiempo_disponible = $existe_historial_tiempo->total_tiempo;
                }
            }
            $tiempo_disponible_total += $tiempo_disponible;

            // historial_fallas
            $tiempo_muerto = 0;
            $ultimo_dia = IndicadorController::obtenerUltimoDiaMes($am);
            $tiempo_muerto = HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->sum("tiempo_falla");
            $tiempo_muerto_total += $tiempo_muerto;

            // numero de fallas
            $numero_fallas = 0;
            $numero_fallas = count(HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->get());
            $numero_fallas_total += $numero_fallas;

            if ($numero_fallas > 0) {
                $calculo_mtbf = ($tiempo_disponible - $tiempo_muerto) / $numero_fallas;
                $mtbf[] = [$meses[$mes], (float)$calculo_mtbf];
            } else {
                $mtbf[] = [$meses[$mes], 0];
            }
        }

        return response()->JSON([
            "sw" => true,
            "datos" => $mtbf,
            "tiempo_disponible_total" => $tiempo_disponible_total,
            "tiempo_muerto_total" => $tiempo_muerto_total,
            "numero_fallas" => $numero_fallas,
        ]);
    }
    public function getMTTR(Request $request)
    {
        $anio = $request->anio;
        $mes = $request->mes;
        $nro = $request->nro;
        $equipo_id = $request->equipo_id;

        $meses = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];

        $existe = Indicador::where("tipo", "MTBF")->orderBy("id")->get()->first();
        if ($existe) {
            $existe->nro = (int)$nro;
            $existe->save();
        } else {
            Indicador::create([
                "tipo" => "MTTR",
                "nro" => $nro
            ]);
        }

        $tiempo_muerto_total = 0;
        $numero_fallas_total = 0;
        $mttr = [];

        // armar fecha_filtro
        $fecha_filtro = $anio . "-" . ($mes < 10 ? '0' . $mes : $mes);
        $registro_final = HistorialFalla::where("fecha_falla", "LIKE", "$fecha_filtro%")->get()->last();
        Log::debug($fecha_filtro);
        $registro_inicial = HistorialFalla::where("fecha_falla", "<=", $registro_final->fecha_falla)->get()->first();

        $anios_meses = IndicadorController::obtenerAnioMesesEntreFechas($registro_inicial->fecha_falla, $registro_final->fecha_falla);

        foreach ($anios_meses as $am) {
            $anio = date("Y", strtotime($am));
            $mes = date("m", strtotime($am));
            // historial_fallas
            $tiempo_muerto = 0;
            $ultimo_dia = IndicadorController::obtenerUltimoDiaMes($am);
            $tiempo_muerto = HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->sum("tiempo_falla");
            $tiempo_muerto_total += $tiempo_muerto;

            // numero de fallas
            $numero_fallas = 0;
            $numero_fallas = count(HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->get());
            $numero_fallas_total += $numero_fallas;

            if ($numero_fallas > 0) {
                $calculo_mttr = $tiempo_muerto / $numero_fallas;
                $mttr[] = [$meses[$mes], (float)$calculo_mttr];
            } else {
                $mttr[] = [$meses[$mes], 0];
            }
        }

        return response()->JSON([
            "sw" => true,
            "datos" => $mttr,
            "tiempo_muerto_total" => $tiempo_muerto_total,
            "numero_fallas" => $numero_fallas,
        ]);
    }
    public function getDisponibilidad(Request $request)
    {
        $anio = $request->anio;
        $mes = $request->mes;
        $nro = $request->nro;
        $equipo_id = $request->equipo_id;

        $meses = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];

        $existe = Indicador::where("tipo", "MTBF")->orderBy("id")->get()->first();
        if ($existe) {
            $existe->nro = (int)$nro;
            $existe->save();
        } else {
            Indicador::create([
                "tipo" => "DISPONIBILIDAD",
                "nro" => $nro
            ]);
        }

        $tiempo_disponible_total = 0;
        $tiempo_muerto_total = 0;
        $numero_fallas_total = 0;
        $mttr = [];
        $mtbf = [];
        $disponibilidad = [];

        // armar fecha_filtro
        $fecha_filtro = $anio . "-" . ($mes < 10 ? '0' . $mes : $mes);
        $registro_final = HistorialFalla::where("fecha_falla", "LIKE", "$fecha_filtro%")->get()->last();
        Log::debug($fecha_filtro);
        $registro_inicial = HistorialFalla::where("fecha_falla", "<=", $registro_final->fecha_falla)->get()->first();

        $anios_meses = IndicadorController::obtenerAnioMesesEntreFechas($registro_inicial->fecha_falla, $registro_final->fecha_falla);

        foreach ($anios_meses as $am) {
            $anio = date("Y", strtotime($am));
            $mes = date("m", strtotime($am));
            // tiempo_disponible
            $tiempo_disponible = 0;
            $existe_historial_tiempo = HistorialTiempo::where("anio", "=", $anio)
                ->where("mes", "=", $mes)
                ->where("equipo_id", $equipo_id)
                ->get()->first();
            if ($existe_historial_tiempo) {
                $tiempo_disponible = $existe_historial_tiempo->total_tiempo;
            } else {
                $existe_historial_tiempo = HistorialTiempo::where("anio", "<=", $anio)
                    ->where("mes", "<=", $mes)
                    ->where("equipo_id", $equipo_id)
                    ->orderBy("anio", "asc")
                    ->orderBy("mes", "asc")->get()->last();
                if ($existe_historial_tiempo) {
                    $tiempo_disponible = $existe_historial_tiempo->total_tiempo;
                }
            }
            $tiempo_disponible_total += $tiempo_disponible;

            // historial_fallas
            $tiempo_muerto = 0;
            $ultimo_dia = IndicadorController::obtenerUltimoDiaMes($am);
            $tiempo_muerto = HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->sum("tiempo_falla");
            $tiempo_muerto_total += $tiempo_muerto;

            // numero de fallas
            $numero_fallas = 0;
            $numero_fallas = count(HistorialFalla::where("fecha_falla", "<=", "$ultimo_dia")
                ->where("equipo_id", $equipo_id)
                ->get());
            $numero_fallas_total += $numero_fallas;

            if ($numero_fallas > 0) {
                $calculo_mttr = $tiempo_muerto / $numero_fallas;
                $mttr[] = [$meses[$mes], (float)$calculo_mttr];
                $calculo_mtbf = ($tiempo_disponible - $tiempo_muerto) / $numero_fallas;
                $mtbf[] = [$meses[$mes], (float)$calculo_mtbf];
            } else {
                $calculo_mttr = 0;
                $calculo_mtbf = 0;
                $mttr[] = [$meses[$mes], 0];
                $mtbf[] = [$meses[$mes], 0];
            }

            if ($calculo_mttr > 0) {
                $calculo_disponibilidad = $calculo_mtbf / $calculo_mttr;
                $disponibilidad[] = [$meses[$mes], (float)$calculo_disponibilidad];
            } else {
                $disponibilidad[] = [$meses[$mes], 0];
            }
        }

        return response()->JSON([
            "sw" => true,
            "datos" => $disponibilidad,
            "tiempo_muerto_total" => $tiempo_muerto_total,
            "numero_fallas" => $numero_fallas,
        ]);
    }

    public static function obtenerUltimoDiaMes($fecha)
    {
        $ultimoDia = date('Y-m-t', strtotime($fecha));
        return $ultimoDia;
    }

    function obtenerAnioMesesEntreFechas($fecha1, $fecha2)
    {
        $meses = array();

        $inicio = new DateTime($fecha1);
        $fin = new DateTime($fecha2);

        $meses[] = $inicio->format('Y-m');

        while ($inicio < $fin) {
            $inicio->add(new DateInterval('P1M'));
            $meses[] = $inicio->format('Y-m');
        }

        return $meses;
    }

    function obtenerMesesEntreFechas($fecha1, $fecha2)
    {
        $meses = array();

        $inicio = new DateTime($fecha1);
        $fin = new DateTime($fecha2);

        $meses[] = (int)$inicio->format('m');

        while ($inicio < $fin) {
            $inicio->add(new DateInterval('P1M'));
            $meses[] = (int)$inicio->format('m');
        }

        return $meses;
    }
}
