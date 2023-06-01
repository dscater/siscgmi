<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EntradaHerramienta extends Model
{
    use HasFactory;

    protected $fillable = [
        "factura",
        "herramienta_id",
        "cantidad",
        "unidad_medida",
        "precio",
        "total",
        "fecha",
    ];

    public function herramienta()
    {
        return $this->belongsTo(Herramienta::class, 'herramienta_id');
    }
}
