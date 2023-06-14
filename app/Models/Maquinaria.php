<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Maquinaria extends Model
{
    use HasFactory;

    protected $fillable = [
        "equipo_id", "codificacion", "descripcion", "prioridad",
        "descripcion", "prioridad",
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

    protected $appends = ["url_foto", "url_archivo", "detalle_equipo"];

    public function getDetalleEquipoAttribute()
    {
        return $this->equipo->codigo . " | " . $this->equipo->nombre . " | " . $this->equipo->area->nombre . " | " . $this->equipo->sistema->nombre;
    }

    public function getUrlFotoAttribute()
    {
        if ($this->foto && $this->foto != "") {
            return asset("imgs/maquinarias/" . $this->foto);
        }
        return asset("imgs/maquinarias/default.png");
    }

    public function getUrlArchivoAttribute()
    {
        if ($this->archivo && $this->archivo != "") {
            return asset("files/maquinarias/" . $this->archivo);
        }
        return false;
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }
}
