<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PedidoRepuesto extends Model
{
    use HasFactory;

    protected $fillable = ["orden_id"];

    public function orden_trabajo()
    {
        return $this->belongsTo(OrdenTrabajo::class, 'orden_id');
    }

    public function detalle_pedidos()
    {
        return $this->hasMany(DetallePedido::class, 'pedido_repuesto_id');
    }
}
