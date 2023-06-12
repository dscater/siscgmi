<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenGenerada extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_id",
        "archivo",
        "descripcion_documentacion",
        "comentario",
    ];
}
