<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEntradaHerramientasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('entrada_herramientas', function (Blueprint $table) {
            $table->id();
            $table->string("factura", 255)->nullable();
            $table->unsignedInteger("herramienta_id");
            $table->double("cantidad");
            $table->string("unidad_medida");
            $table->decimal("precio", 24, 2);
            $table->decimal("total", 24, 2);
            $table->date("fecha");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('entrada_herramientas');
    }
}
