<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHistorialFallasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('historial_fallas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_id");
            $table->bigInteger("nro_codificacion");
            $table->string("codificacion", 255);
            $table->string("tipo_falla");
            $table->text("descripcion_falla");
            $table->date("fecha_inicio");
            $table->time("hora_inicio");
            $table->date("fecha_termino");
            $table->time("hora_termino");
            $table->double("tiempo_ejecucion");
            $table->unsignedBigInteger("equipo_id");
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
        Schema::dropIfExists('historial_fallas');
    }
}
