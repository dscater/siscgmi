<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GamaDetalles extends Model
{
    use HasFactory;

    protected $fillable = [
        "gama_id",
        "tarea",
        "tiempo",
        "chekado"
    ];

    protected $appends = ["enviando", "actualizado"];

    public function getEnviandoAttribute()
    {
        return false;
    }

    public function getActualizadoAttribute()
    {
        return false;
    }
}
