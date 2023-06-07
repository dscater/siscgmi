<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateKardexRepuestosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('kardex_repuestos', function (Blueprint $table) {
            $table->id();
            $table->string("tipo_registro"); //ENTRADA, ELIMINACION,ORDEN, ETC...
            $table->unsignedBigInteger("registro_id");
            $table->unsignedBigInteger("repuesto_id");
            $table->text("detalle")->nullable();
            $table->decimal("precio", 24, 2);
            $table->string("tipo_is", 24, 2); // INGRESO - EGRESO
            $table->double("cantidad_ingreso");
            $table->double("cantidad_salida");
            $table->double("cantidad_saldo");
            $table->decimal("cu", 24, 2);
            $table->decimal("monto_ingreso", 24, 2);
            $table->decimal("monto_salida", 24, 2);
            $table->decimal("monto_saldo", 24, 2);
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
        Schema::dropIfExists('kardex_repuestos');
    }
}
