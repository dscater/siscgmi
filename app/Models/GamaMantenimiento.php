<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GamaMantenimiento extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "subfamilia_id",
        "equipo_id",
        "descripcion",
    ];

    public function gama_detalles()
    {
        return $this->hasMany(GamaDetalles::class, 'gama_id');
    }

    public function subfamilia()
    {
        return $this->belongsTo(SubFamilia::class, 'subfamilia_id');
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }
}
