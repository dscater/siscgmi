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
}
