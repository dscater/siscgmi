<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHistorialTiemposTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('historial_tiempos', function (Blueprint $table) {
            $table->id();
            $table->integer("anio");
            $table->string("mes");
            $table->unsignedBigInteger("equipo_id");
            $table->string("codificacion", 255);
            $table->integer("total_tiempo");
            $table->timestamps();

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
        Schema::dropIfExists('historial_tiempos');
    }
}
