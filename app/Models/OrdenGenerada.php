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

    protected $appends = ["url_archivo"];

    public function getUrlArchivoAttribute()
    {
        if ($this->archivo && $this->archivo != "") {
            return asset("files/" . $this->archivo);
        }
        return null;
    }

    public function orden()
    {
        return $this->belongsTo(OrdenTrabajo::class, 'orden_id');
    }

    public function detalle_repuestos()
    {
        return $this->hasMany(DetalleRepuesto::class, 'orden_generada_id');
    }

    public function detalle_herramientas()
    {
        return $this->hasMany(DetalleHerramienta::class, 'orden_generada_id');
    }

    public function detalle_personals()
    {
        return $this->hasMany(DetallePersonal::class, 'orden_generada_id');
    }
}
