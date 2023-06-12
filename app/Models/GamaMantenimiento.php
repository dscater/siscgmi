<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GamaMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "familia_id",
        "equipo_id",
        "descripcion",
    ];
}
