<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Familia extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "nombre",
    ];

    protected $appends = ["full_name"];
    public function getFullNameAttribute()
    {
        return $this->codigo . ' | ' . $this->nombre;
    }
}
