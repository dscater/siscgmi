<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Frecuencia extends Model
{
    use HasFactory;

    protected $fillable = [
        "variable_id",
        "frecuencia",
    ];

    protected $appends = ["detalle_variable", "full_name"];

    public function getFullNameAttribute()
    {
        return $this->variable->id . " | " . $this->variable->nombre . ' | ' . $this->variable->unidad;
    }

    public function getDetalleVariableAttribute()
    {
        return $this->variable->id . " | " . $this->variable->nombre . ' | ' . $this->variable->unidad;
    }

    public function variable()
    {
        return $this->belongsTo(VariableControl::class, 'variable_id');
    }
}
