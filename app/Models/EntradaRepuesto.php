<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EntradaRepuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "factura",
        "repuesto_id",
        "cantidad",
        "precio",
        "total",
        "fecha",
    ];

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }
}
