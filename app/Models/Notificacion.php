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

    protected $appends = ["fecha_hace", "hace"];
    public function getFechaHaceAttribute()
    {
        $fecha_hora = date("d/m/Y H:i", strtotime($this->created_at)) . "<br>";
        $hace = $this->created_at->diffForHumans();
        return $fecha_hora . $hace;
    }
    public function getHaceAttribute()
    {
        return $this->created_at->diffForHumans();
    }

    public function orden_generada()
    {
        return $this->belongsTo(OrdenGenerada::class, 'registro_id');
    }

    public function orden_trabajo()
    {
        return $this->belongsTo(OrdenTrabajo::class, 'registro_id');
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
