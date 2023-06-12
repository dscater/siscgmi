<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGamaDetallesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('gama_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("gama_id");
            $table->string("tarea");
            $table->double("tiempo");
            $table->timestamps();

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
        Schema::dropIfExists('gama_detalles');
    }
}
