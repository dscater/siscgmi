<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sistema extends Model
{
    use HasFactory;
    protected $fillable = [
        "area_id",
        "codigo",
        "nombre",
    ];

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }
}
