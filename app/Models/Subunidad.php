<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subunidad extends Model
{
    use HasFactory;

    protected $fillable = [
        "area_id",
        "sistema_id",
        "equipo_id",
        "codigo",
        "nombre",
        "numero",
        "codigo2",
    ];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }
    public function sistema()
    {
        return $this->belongsTo(Sistema::class, 'sistema_id');
    }
    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }
}
