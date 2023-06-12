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
    ];
}
