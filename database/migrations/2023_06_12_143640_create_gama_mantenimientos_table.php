<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGamaMantenimientosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('gama_mantenimientos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255)->unique();
            $table->unsignedBigInteger("familia_id");
            $table->unsignedBigInteger("equipo_id");
            $table->text("descripcion")->nullable();
            $table->timestamps();

            $table->foreign("familia_id")->on("familias")->references("id");
            $table->foreign("equipo_id")->on("equipos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('gama_mantenimientos');
    }
}
