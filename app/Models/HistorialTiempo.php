<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistorialTiempo extends Model
{
    use HasFactory;

    protected $fillable = [
        "anio",
        "mes",
        "equipo_id",
        "codificacion",
        "total_tiempo",
    ];

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }

    public function detalle_tiempos()
    {
        return $this->hasMany(DetalleTiempo::class, 'historial_tiempo_id');
    }

    // FUNCIONES

    public static function getDetalleTiempos($anio, $mes)
    {
        $fechas = array();

        $dias_en_mes = cal_days_in_month(CAL_GREGORIAN, $mes, $anio);

        for ($dia = 1; $dia <= $dias_en_mes; $dia++) {
            $fecha = sprintf('%04d-%02d-%02d', $anio, $mes, $dia);
            $fechas[] = [
                "fecha" => $fecha,
                "tiempo" => 390,
                "comentario" => "",
            ];
        }

        return $fechas;
    }
}
