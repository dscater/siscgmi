<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Herramienta extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "codificacion",
        "nombre",
        "descripcion",
        "clasificacion",
        "cod_clasificacion",
        "marca",
        "modelo",
        "serie",
        "costo",
        "unidad_medida",
        "proveedor",
        "dir",
        "fono",
        "correo",
        "almacen",
        "fabricante",
        "terciarios",
        "nombre_contacto",
        "num_fono",
        "correo_fabricante",
        "dir_fabricante",
        "num_identificacion",
        "e_tecnicas",
        "foto",
    ];

    protected $appends = ["url_foto", "full_name"];

    public function getFullNameAttribute()
    {
        return $this->codigo . ' | ' . $this->nombre;
    }

    public function getUrlFotoAttribute()
    {
        if ($this->foto && $this->foto != "") {
            return asset("imgs/herramientas/" . $this->foto);
        }
        return asset("imgs/herramientas/default.png");
    }

    public function entradas()
    {
        return $this->hasMany(EntradaHerramienta::class, 'herramienta_id');
    }
}
