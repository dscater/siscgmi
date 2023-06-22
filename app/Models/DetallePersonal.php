<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePersonal extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_generada_id",
        "personal_id",
        "costo",
        "chekado"
    ];

    protected $appends = ["enviando", "actualizado"];

    public function getEnviandoAttribute()
    {
        return false;
    }

    public function getActualizadoAttribute()
    {
        return false;
    }

    public function personal()
    {
        return $this->belongsTo(Personal::class, 'personal_id');
    }
}
