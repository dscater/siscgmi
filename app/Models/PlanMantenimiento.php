<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codificacion",
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
        "estado",
    ];

    public function subunidad()
    {
        return $this->belongsTo(Subunidad::class, 'subunidad_id');
    }

    public function gama()
    {
        return $this->belongsTo(GamaMantenimiento::class, 'gama_id');
    }

    public function variable_control()
    {
        return $this->belongsTo(VariableControl::class, 'variable_control_id');
    }

    public function frecuencia()
    {
        return $this->belongsTo(Frecuencia::class, 'frecuencia_id');
    }

    public function programacions()
    {
        return $this->hasMany(Programacion::class, 'plan_mantenimiento_id');
    }
}
