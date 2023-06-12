<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePersonalsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('personals', function (Blueprint $table) {
            $table->id();
            $table->string("tipo_mo", 255);
            $table->unsignedBigInteger("user_id")->nullable();
            $table->string("razon_social", 255);
            $table->string("nro_doc", 255)->nullable();
            $table->string("especialidad", 255)->nullable();
            $table->string("correo", 255)->nullable();
            $table->string("telefono", 255)->nullable();
            $table->string("domicilio", 255)->nullable();
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('personals');
    }
}
