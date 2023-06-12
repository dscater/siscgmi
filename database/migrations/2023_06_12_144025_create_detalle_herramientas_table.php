<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetalleHerramientasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_herramientas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_generada_id");
            $table->unsignedBigInteger("herramienta_id");
            $table->double("cantidad_solicitada");
            $table->decimal("costo", 24, 2);
            $table->timestamps();

            $table->foreign("orden_generada_id")->on("orden_generadas")->references("id");
            $table->foreign("herramienta_id")->on("herramientas")->references("id");

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detalle_herramientas');
    }
}
