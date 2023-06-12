<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePersonal extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_generada_id",
        "personal_id",
        "costo",
    ];
}
