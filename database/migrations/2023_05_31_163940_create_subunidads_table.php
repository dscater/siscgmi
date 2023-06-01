<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSubunidadsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('subunidads', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("area_id");
            $table->unsignedBigInteger("sistema_id");
            $table->unsignedBigInteger("equipo_id");
            $table->string("codigo", 10)->unique();
            $table->string("nombre", 255);
            $table->string("numero");
            $table->string("codigo2", 155)->unique();
            $table->timestamps();

            $table->foreign("area_id")->on("areas")->references("id");
            $table->foreign("sistema_id")->on("sistemas")->references("id");
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
        Schema::dropIfExists('subunidads');
    }
}
