<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleHerramienta extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_generada_id",
        "herramienta_id",
        "cantidad_solicitada",
        "costo",
        "total",
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

    public function herramienta()
    {
        return $this->belongsTo(Herramienta::class, 'herramienta_id');
    }
}
