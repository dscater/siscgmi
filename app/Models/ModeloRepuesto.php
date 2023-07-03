<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModeloRepuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "repuesto_id",
        "anio_ini",
        "trimestre_ini",
        "anio_fin",
        "trimestre_fin",
        "demanda",
    ];

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }
}
