<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Maquinaria extends Model
{
    use HasFactory;

    protected $fillable = [
        "equipo_id", "descripcion", "prioridad",
        "ubicacion", "tipo", "marca",
        "modelo", "serie", "costo",
        "fecha_compra", "fecha_instalacion", "garantia_meses",
        "peso", "altura", "ancho", "largo",
        "voltios", "capacidad", "e_tecnicas",
        "fecha_ultimo_mantenimiento", "fecha_utlimo_termino",
        "estado", "fabricantes", "proveedor",
        "terciarios", "nombre_contacto", "num_fono",
        "correo", "dir", "num_identificacion", "foto",
        "archivo",
    ];

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }
}
