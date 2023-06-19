<?php

namespace App\Models;

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

    public function orden_generada()
    {
        return $this->hasOne(OrdenGenerada::class, 'orden_id');
    }
}
