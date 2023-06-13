<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubFamilia extends Model
{
    use HasFactory;

    protected $fillable = [
        "familia_id",
        "nombre",
    ];
    protected $appends = ["full_name"];

    public function familia()
    {
        return $this->belongsTo(Familia::class, 'familia_id');
    }

    public function getFullNameAttribute()
    {
        return $this->familia->codigo . ' | ' . $this->familia->nombre . ' | ' . $this->nombre;
    }
}
