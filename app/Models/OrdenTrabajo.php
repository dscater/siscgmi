<?php

namespace App\Models;

use DateTime;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenTrabajo extends Model
{
    use HasFactory;

    protected $fillable = [
        "fecha_programada",
        "subunidad_id",
        "gama_id",
        "prioridad",
        "tiempo",
        "dias",
        "tipo_mantenimiento",
        "fecha_inicio",
        "hora_inicio",
        "fecha_termino",
        "hora_termino",
        "tiempo_ejecucion",
        "parada_maquina",
        "estado",
        "razon",
        "comentario",
    ];

    public function subunidad()
    {
        return $this->belongsTo(Subunidad::class, 'subunidad_id');
    }

    public function gama()
    {
        return $this->belongsTo(GamaMantenimiento::class, 'gama_id');
    }

    public function orden_generada()
    {
        return $this->hasOne(OrdenGenerada::class, 'orden_id');
    }

    public function historial_fallas()
    {
        return $this->hasMany(HistorialFalla::class, "orden_id");
    }

    public static function obtenerFechasSemana($semana, $anio)
    {
        $fechas = array();
        $primerDia = new DateTime();
        $primerDia->setISODate($anio, $semana, 1); // Establece el primer día de la semana

        // Itera sobre los días de la semana
        for ($i = 0; $i < 7; $i++) {
            $fecha = clone $primerDia; // Crea una copia de la fecha actual
            $fecha->modify("+$i day"); // Avanza al siguiente día de la semana
            $fechas[] = $fecha->format('Y-m-d'); // Agrega la fecha al arreglo
        }

        return $fechas;
    }
}
