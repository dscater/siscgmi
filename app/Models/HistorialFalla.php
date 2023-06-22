<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistorialFalla extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_id",
        "nro_codificacion",
        "codificacion",
        "tipo_falla",
        "descripcion_falla",
        "fecha_inicio",
        "hora_inicio",
        "fecha_termino",
        "hora_termino",
        "tiempo_ejecucion",
        "equipo_id",
    ];
}
