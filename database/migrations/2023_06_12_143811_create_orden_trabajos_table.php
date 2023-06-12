<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdenTrabajosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orden_trabajos', function (Blueprint $table) {
            $table->id();
            $table->date("fecha_programada");
            $table->unsignedBigInteger("subunidad_id");
            $table->unsignedBigInteger("gama_id");
            $table->string("prioridad");
            $table->double("tiempo");
            $table->double("dias");
            $table->string("tipo_mantenimiento");
            $table->string("estado");
            $table->timestamps();

            $table->foreign("subunidad_id")->on("subunidads")->references("id");
            $table->foreign("gama_id")->on("gama_mantenimientos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orden_trabajos');
    }
}
