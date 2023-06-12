<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlanMantenimientosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('plan_mantenimientos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("subunidad_id");
            $table->unsignedBigInteger("gama_id");
            $table->string("pm", 255);
            $table->string("prioridad", 255);
            $table->double("tiempo"); //suma de todas las tareas en gama de mantenimientos
            $table->double("dias")->nullable();
            $table->string("tipo_mantenimiento");
            $table->date("ultima_fecha_programada")->nullable();
            $table->date("ultima_fecha_terminada")->nullable();
            $table->string("programacion", 255);
            $table->date("fecha_final")->nullable();
            $table->unsignedBigInteger("variable_control_id");
            $table->unsignedBigInteger("frecuencia_id");
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
        Schema::dropIfExists('plan_mantenimientos');
    }
}
