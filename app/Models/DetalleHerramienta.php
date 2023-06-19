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
    ];

    public function herramienta()
    {
        return $this->belongsTo(Herramienta::class, 'herramienta_id');
    }
}
