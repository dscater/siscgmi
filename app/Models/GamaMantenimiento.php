<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GamaMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "codificacion",
        "subfamilia_id",
        "equipo_id",
        "descripcion",
    ];

    protected $appends = ["full_name", "tiempo_total"];
    public function getTiempoTotalAttribute()
    {
        return $this->gama_detalles()->sum("tiempo");
    }

    public function getFullNameAttribute()
    {
        return $this->codigo . ' | ' . $this->descripcion;
    }

    public function gama_detalles()
    {
        return $this->hasMany(GamaDetalles::class, 'gama_id');
    }

    public function subfamilia()
    {
        return $this->belongsTo(SubFamilia::class, 'subfamilia_id');
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }

    public function plan_mantenimiento()
    {
        return $this->hasOne(PlanMantenimiento::class, 'gama_id');
    }
}
