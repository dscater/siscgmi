<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Programacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "plan_mantenimiento_id",
        "numero",
        "dias",
        "fecha",
    ];
}
