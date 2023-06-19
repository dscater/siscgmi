<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleRepuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_generada_id",
        "repuesto_id",
        "cantidad_requerida",
        "costo",
        "total",
    ];

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }
}
