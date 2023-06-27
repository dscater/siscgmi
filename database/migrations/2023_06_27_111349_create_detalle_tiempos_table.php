<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetalleTiemposTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_tiempos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("historial_tiempo_id");
            $table->date("fecha");
            $table->integer("tiempo");
            $table->text("comentario")->nullable();
            $table->timestamps();
            $table->foreign("historial_tiempo_id")->on("historial_tiempos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detalle_tiempos');
    }
}
