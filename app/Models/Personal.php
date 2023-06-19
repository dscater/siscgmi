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

    protected $appends = ["full_name"];

    public function getFullNameAttribute()
    {
        return $this->razon_social . ' | ' . $this->nro_doc . ' | ' . $this->especialidad;
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
