<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetallePedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_pedidos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("pedido_repuesto_id");
            $table->unsignedBigInteger("repuesto_id");
            $table->double("cantidad_requerida");
            $table->timestamps();

            $table->foreign("pedido_repuesto_id")->on("pedido_repuestos")->references("id");
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
        Schema::dropIfExists('detalle_pedidos');
    }
}
