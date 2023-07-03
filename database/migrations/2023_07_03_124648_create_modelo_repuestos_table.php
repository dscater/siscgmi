<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateModeloRepuestosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('modelo_repuestos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("repuesto_id");
            $table->integer("anio_ini");
            $table->integer("trimestre_ini");
            $table->integer("anio_fin");
            $table->integer("trimestre_fin");
            $table->double("demanda");
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
        Schema::dropIfExists('modelo_repuestos');
    }
}
