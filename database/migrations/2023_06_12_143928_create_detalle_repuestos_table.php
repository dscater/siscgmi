<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetalleRepuestosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_repuestos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_generada_id");
            $table->unsignedBigInteger("repuesto_id");
            $table->double("cantidad_requerida");
            $table->decimal("costo", 24, 2);
            $table->decimal("total", 24, 2);
            $table->timestamps();

            $table->foreign("orden_generada_id")->on("orden_generadas")->references("id");
            $table->foreign("repuesto_id")->on("repuestos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detalle_repuestos');
    }
}
