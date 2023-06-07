<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EntradaRepuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "factura",
        "repuesto_id",
        "cantidad",
        "precio",
        "total",
        "fecha",
    ];

    protected $appends = ["detalle_repuesto"];

    public function getDetalleRepuestoAttribute()
    {
        return $this->repuesto->codigo . ' | ' . $this->repuesto->nombre;
    }

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }
}
