<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Repuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "nombre",
        "descripcion",
        "marca",
        "modelo",
        "serie",
        "equipo_id",
        "precio",
        "stock_min",
        "stock_max",
        "unidad_medida",
        "dir",
        "fono",
        "correo",
        "almacen",
        "fabricante",
        "proveedor",
        "terciarios",
        "nombre_contacto",
        "num_fono",
        "correo_fabricante",
        "dir_fabricante",
        "num_identificacion",
    ];
}
