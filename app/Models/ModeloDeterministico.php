<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModeloDeterministico extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo", "nombre", "descripcion", "repuesto_id",
        "sm", "it", "cpo", "ct_ordenar", "c_ins",
        "c_em", "c_ordenar", "precio_compra", "ct_adqui",
        "c_impor", "c_alma_ext", "oc_adqui", "c_adqui",
        "c_alqui", "area_ocupada", "c_espa",
        "vp_rep", "cantp_rep", "costop_rep",
        "tasa_ia","tasa_ia_calculado", "costo_capital", "ct_almacenamiento",
        "c_depreciacion", "c_gi", "oc_mantenimiento",
        "c_mantenimiento", "leadtime", "procesamiento_pedido",
        "fabricacion_productos", "tiempo_transito", "inspeccion_control",
        "unidad",
    ];

    protected $appends = ["tasa_calculada"];

    public function getTasaCalculadaAttribute()
    {
        try {
            if ($this->tasa_ia && $this->tasa_ia != "") {
                return number_format((float)$this->tasa_ia / 400, 2, '.', '');
            }
        } catch (\Exception $e) {
            return 0;
        }
    }

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }
}
