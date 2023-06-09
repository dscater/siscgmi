<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{
    use HasFactory;

    protected $fillable = [
        "area_id",
        "sistema_id",
        "codigo",
        "nombre",
        "numero",
        "codigo2",
    ];

    protected $appends = ["full_name"];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }
    public function sistema()
    {
        return $this->belongsTo(Sistema::class, 'sistema_id');
    }

    public function getFullNameAttribute()
    {
        return $this->codigo . " | " . $this->nombre;
    }

    public function historial_fallas()
    {
        return $this->hasMany(HistorialFalla::class, "equipo_id");
    }

    public function historial_tiempos()
    {
        return $this->hasMany(HistorialTiempo::class, "equipo_id");
    }
}
