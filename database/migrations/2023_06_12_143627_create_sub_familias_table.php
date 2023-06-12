<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSubFamiliasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sub_familias', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("familia_id");
            $table->string("nombre", 255);
            $table->timestamps();

            $table->foreign("familia_id")->on("familias")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sub_familias');
    }
}
