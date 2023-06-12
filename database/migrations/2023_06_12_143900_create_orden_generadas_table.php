<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdenGeneradasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orden_generadas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_id");
            $table->string("archivo", 255);
            $table->text("descripcion_documentacion")->nullable();
            $table->text("comentario")->nullable();
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
        Schema::dropIfExists('orden_generadas');
    }
}
