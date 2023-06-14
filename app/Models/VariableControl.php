<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VariableControl extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "unidad",
    ];

    protected $appends = ["full_name"];

    public function getFullNameAttribute()
    {
        return $this->id . ' | ' . $this->nombre . ' | ' . $this->unidad;
    }
}
