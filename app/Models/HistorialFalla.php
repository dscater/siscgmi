<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HistorialFalla extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_id",
        "nro_codificacion",
        "codificacion",
        "tipo_falla",
        "descripcion_falla",
        "fecha_inicio",
        "hora_inicio",
        "fecha_termino",
        "hora_termino",
        "tiempo_ejecucion",
        "fecha_falla",
        "hora_falla",
        "tiempo_falla",
        "equipo_id",
    ];

    public static function ultimoNumero()
    {
        $ultimo_numero = 1;
        $last = HistorialFalla::orderBy("created_at", "asc")->get()->last();
        if ($last) {
            $ultimo_numero = (int)$last->nro_codificacion + 1;
        }

        return $ultimo_numero;
    }

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'equipo_id');
    }

    public function orden_trabajo()
    {
        return $this->belongsTo(OrdenTrabajo::class, 'orden_id');
    }
}
