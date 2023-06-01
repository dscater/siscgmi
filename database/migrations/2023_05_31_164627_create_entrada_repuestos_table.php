<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEntradaRepuestosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('entrada_repuestos', function (Blueprint $table) {
            $table->id();
            $table->string("factura", 255)->nullable();
            $table->unsignedInteger("repuesto_id");
            $table->double("cantidad");
            $table->decimal("precio", 24, 2);
            $table->decimal("total", 24, 2);
            $table->date("fecha");
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
        Schema::dropIfExists('entrada_repuestos');
    }
}
