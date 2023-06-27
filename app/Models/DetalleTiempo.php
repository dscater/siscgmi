<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleTiempo extends Model
{
    use HasFactory;
    protected $fillable = [
        "historial_tiempo_id",
        "fecha",
        "tiempo",
        "comentario",
    ];

    public function setComentarioAttribute($value)
    {
        $this->attributes['comentario'] = mb_strtoupper($value);
    }

    public function historial_tiempo()
    {
        return $this->belongsTo(HistorialTiempo::class, 'historial_tiempo_id');
    }
}
