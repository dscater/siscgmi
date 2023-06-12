<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "subunidad_id",
        "gama_id",
        "pm",
        "prioridad",
        "tiempo",
        "dias",
        "tipo_mantenimiento",
        "ultima_fecha_programada",
        "ultima_fecha_terminada",
        "programacion",
        "fecha_final",
        "variable_control_id",
        "frecuencia_id",
    ];
}
