<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KardexRepuesto extends Model
{
    use HasFactory;

    protected $fillable = [
        "tipo_registro",
        "registro_id",
        "repuesto_id",
        "detalle",
        "precio",
        "tipo_is",
        "cantidad_ingreso",
        "cantidad_salida",
        "cantidad_saldo",
        "cu",
        "monto_ingreso",
        "monto_salida",
        "monto_saldo",
        "fecha",
    ];

    public function repuesto()
    {
        return $this->belongsTo(Repuesto::class, 'repuesto_id');
    }

    // REGISTRAR ENTRADA
    public static function registroIngreso($tipo_registro, $registro_id = 0, Repuesto $repuesto, $cantidad, $precio, $detalle = "")
    {
        //buscar el ultimo registro y usar sus valores
        $ultimo = KardexRepuesto::where('repuesto_id', $repuesto->id)
            ->orderBy('created_at', 'asc')
            ->get()
            ->last();
        $monto = (float)$cantidad * (float)$precio;
        if ($ultimo) {
            if (!$detalle || $detalle == "") {
                $detalle = "ENTRADA DE REPUESTO/INSUMO";
            }
            KardexRepuesto::create([
                'tipo_registro' => $tipo_registro, //ENTRADA, EGRESO, ORDEN DE VENTA, COMPRA,etc...
                'registro_id' => $registro_id,
                'repuesto_id' => $repuesto->id,
                'detalle' => $detalle,
                'precio' => $precio,
                'tipo_is' => 'INGRESO',
                'cantidad_ingreso' => $cantidad,
                'cantidad_saldo' => (float)$ultimo->cantidad_saldo + (float)$cantidad,
                'cu' => $repuesto->precio,
                'monto_ingreso' => $monto,
                'monto_saldo' => (float)$ultimo->monto_saldo + $monto,
                'fecha' => date('Y-m-d'),
            ]);
        } else {
            $detalle = "VALOR INICIAL";
            KardexRepuesto::create([
                'tipo_registro' => $tipo_registro, //ENTRADA, EGRESO, VENTA,etc...
                'registro_id' => $registro_id,
                'repuesto_id' => $repuesto->id,
                'detalle' => $detalle,
                'precio' => $precio,
                'tipo_is' => 'INGRESO',
                'cantidad_ingreso' => $cantidad,
                'cantidad_saldo' => (float)$cantidad,
                'cu' => $repuesto->precio,
                'monto_ingreso' => $monto,
                'monto_saldo' =>  $monto,
                'fecha' => date('Y-m-d'),
            ]);
        }

        // INCREMENTAR STOCK
        Repuesto::incrementarStock($repuesto, $cantidad);

        return true;
    }

    // REGISTRAR EGRESO
    public static function registroEgreso($tipo_registro, $registro_id = 0, Repuesto $repuesto, $cantidad, $precio, $detalle = "")
    {
        //buscar el ultimo registro y usar sus valores
        $ultimo = KardexRepuesto::where('repuesto_id', $repuesto->id)
            ->orderBy('created_at', 'asc')
            ->get()
            ->last();
        $monto = (float)$cantidad * (float)$precio;

        if (!$detalle || $detalle == "") {
            $detalle = "SALIDA DE REPUESTO/INSUMO";
        }

        KardexRepuesto::create([
            'tipo_registro' => $tipo_registro,
            'registro_id' => $registro_id,
            'repuesto_id' => $repuesto->id,
            'detalle' => $detalle,
            'precio' => $precio,
            'tipo_is' => 'EGRESO',
            'cantidad_salida' => $cantidad,
            'cantidad_saldo' => (float)$ultimo->cantidad_saldo - (float)$cantidad,
            'cu' => $precio,
            'monto_salida' => $monto,
            'monto_saldo' => (float)$ultimo->monto_saldo - $monto,
            'fecha' => date('Y-m-d'),
        ]);

        Repuesto::decrementarStock($repuesto, $cantidad);

        return true;
    }

    // ACTUALIZA REGISTROS KARDEX
    // FUNCIÓN QUE ACTUALIZA LOS REGISTROS DEL KARDEX DE UN LUGAR
    // SOLO ACTUALIZARA LOS REGISTROS POSTERIORES AL REGISTRO ACTUALIZADO
    public static function actualizaRegistrosKardex($id, $repuesto_id)
    {
        $siguientes = KardexRepuesto::where("repuesto_id", $repuesto_id)
            ->where("id", ">=", $id)
            ->get();

        foreach ($siguientes as $item) {
            $anterior = KardexRepuesto::where("repuesto_id", $repuesto_id)
                ->where("id", "<", $item->id)->get()
                ->last();

            $datos_actualizacion = [
                "precio" => 0,
                "cantidad_ingreso" => NULL,
                "cantidad_salida" => NULL,
                "cantidad_saldo" => 0,
                "cu" => 0,
                "monto_ingreso" => NULL,
                "monto_salida" => NULL,
                "monto_saldo" => 0,
            ];

            switch ($item->tipo_registro) {
                case 'ENTRADA':
                    $ingreso_repuesto = EntradaRepuesto::find($item->registro_id);
                    $monto = (float)$ingreso_repuesto->cantidad * (float)$ingreso_repuesto->precio;
                    if ($anterior) {
                        $datos_actualizacion["precio"] = $ingreso_repuesto->precio;
                        $datos_actualizacion["cantidad_ingreso"] =  $ingreso_repuesto->cantidad;
                        $datos_actualizacion["cantidad_saldo"] = (float)$anterior->cantidad_saldo + (float)$ingreso_repuesto->cantidad;
                        $datos_actualizacion["cu"] = $ingreso_repuesto->precio;
                        $datos_actualizacion["monto_ingreso"] = $monto;
                        $datos_actualizacion["monto_saldo"] = (float)$anterior->monto_saldo + $monto;
                    } else {
                        $datos_actualizacion["precio"] = $ingreso_repuesto->precio;
                        $datos_actualizacion["cantidad_ingreso"] =  $ingreso_repuesto->cantidad;
                        $datos_actualizacion["cantidad_saldo"] = (float)$ingreso_repuesto->cantidad;
                        $datos_actualizacion["cu"] = $ingreso_repuesto->precio;
                        $datos_actualizacion["monto_ingreso"] = $monto;
                        $datos_actualizacion["monto_saldo"] = $monto;
                    }
                    break;
                case 'DETALLE REPUESTO':
                    $detalle_repuesto = DetalleRepuesto::find($item->registro_id);
                    $monto = (float)$detalle_repuesto->cantidad_requerida * (float)$detalle_repuesto->costo;

                    if ($anterior) {
                        $datos_actualizacion["precio"] = $detalle_repuesto->costo;
                        $datos_actualizacion["cantidad_salida"] =  $detalle_repuesto->cantidad_requerida;
                        $datos_actualizacion["cantidad_saldo"] = (float)$anterior->cantidad_saldo - (float)$detalle_repuesto->cantidad_requerida;
                        $datos_actualizacion["cu"] = $detalle_repuesto->costo;
                        $datos_actualizacion["monto_salida"] = $monto;
                        $datos_actualizacion["monto_saldo"] =  (float)$anterior->monto_saldo - $monto;
                    } else {
                        $datos_actualizacion["precio"] = $detalle_repuesto->costo;
                        $datos_actualizacion["cantidad_salida"] =  $detalle_repuesto->cantidad_requerida;
                        $datos_actualizacion["cantidad_saldo"] = (float)$detalle_repuesto->cantidad_requerida * (-1);
                        $datos_actualizacion["cu"] = $detalle_repuesto->costo;
                        $datos_actualizacion["monto_salida"] = $monto;
                        $datos_actualizacion["monto_saldo"] = $monto * (-1);
                    }

                    break;
                case 'VENTA':
                    $detalle_orden = DetalleVenta::find($item->registro_id);
                    $monto = (float)$detalle_orden->cantidad * (float)$detalle_orden->precio;
                    if ($anterior) {
                        $datos_actualizacion["precio"] = $detalle_orden->precio;
                        $datos_actualizacion["cantidad_salida"] =  $detalle_orden->cantidad;
                        $datos_actualizacion["cantidad_saldo"] = (float)$anterior->cantidad_saldo - (float)$detalle_orden->cantidad;
                        $datos_actualizacion["cu"] = $detalle_orden->precio;
                        $datos_actualizacion["monto_salida"] = $monto;
                        $datos_actualizacion["monto_saldo"] =  (float)$anterior->monto_saldo - $monto;
                    } else {
                        $datos_actualizacion["precio"] = $detalle_orden->precio;
                        $datos_actualizacion["cantidad_salida"] =  $detalle_orden->cantidad;
                        $datos_actualizacion["cantidad_saldo"] = (float)$detalle_orden->cantidad * (-1);
                        $datos_actualizacion["cu"] = $detalle_orden->precio;
                        $datos_actualizacion["monto_salida"] = $monto;
                        $datos_actualizacion["monto_saldo"] = $monto * (-1);
                    }
                    break;
            }

            $item->update($datos_actualizacion);
        }
    }
}
