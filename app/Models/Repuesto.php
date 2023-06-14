<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Repuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "codificacion",
        "nombre",
        "descripcion",
        "marca",
        "modelo",
        "serie",
        "equipo_id",
        "precio",
        "stock_min",
        "stock_max",
        "stock_actual",
        "unidad_medida",
        "dir",
        "fono",
        "correo",
        "almacen",
        "fabricante",
        "proveedor",
        "terciarios",
        "nombre_contacto",
        "num_fono",
        "correo_fabricante",
        "dir_fabricante",
        "num_identificacion",
    ];

    protected $appends = ["detalle_equipo"];

    public function getDetalleEquipoAttribute()
    {
        return $this->equipo->codigo . ' | ' . $this->equipo->nombre;
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }

    public function kardex_repuestos()
    {
        return $this->hasMany(KardexRepuesto::class, 'repuesto_id');
    }

    // FUNCIONES PARA INCREMETAR Y DECREMENTAR EL STOCK
    public static function incrementarStock($repuesto, $cantidad)
    {
        $repuesto->stock_actual = (float)$repuesto->stock_actual + $cantidad;
        $repuesto->save();
        return true;
    }
    public static function decrementarStock($repuesto, $cantidad)
    {
        $repuesto->stock_actual = (float)$repuesto->stock_actual - $cantidad;
        $repuesto->save();
        return true;
    }
}
