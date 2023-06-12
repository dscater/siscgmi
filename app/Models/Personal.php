<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Personal extends Model
{
    use HasFactory;

    protected $fillable = [
        "tipo_mo",
        "user_id",
        "razon_social",
        "nro_doc",
        "especialidad",
        "correo",
        "telefono",
        "domicilio",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
