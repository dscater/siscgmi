<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "notificacion",
        "registro_id",
        "tipo"
    ];

    protected $appends = ["hace"];
    public function getHaceAttribute()
    {
        return $this->created_at->diffForHumans();
    }

    public function orden_generada()
    {
        return $this->belongsTo(OrdenGenerada::class, 'registro_id');
    }

    public function pedido_repuesto()
    {
        return $this->belongsTo(PedidoRepuesto::class, 'registro_id');
    }

    public function notificacion_users()
    {
        return $this->hasMany(NotificacionUser::class, 'notificacion_id');
    }
}
