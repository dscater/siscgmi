<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRepuestosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('repuestos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255)->unique();
            $table->string("nombre", 255);
            $table->text("descripcion");
            $table->string("marca", 255)->nullable();
            $table->string("modelo", 255)->nullable();
            $table->string("serie", 255)->nullable();
            $table->unsignedBigInteger("equipo_id");
            $table->decimal("precio", 24, 2);
            $table->double("stock_min");
            $table->double("stock_max");
            $table->string("unidad_medida", 255)->nullable();
            $table->string("dir", 255)->nullable();
            $table->string("fono", 255)->nullable();
            $table->string("correo", 255)->nullable();
            $table->string("almacen", 255);
            $table->string("fabricante", 255)->nullable();
            $table->string("proveedor", 255);
            $table->string("terciarios", 255)->nullable();
            $table->string("nombre_contacto", 255)->nullable();
            $table->string("num_fono", 255)->nullable();
            $table->string("correo_fabricante", 255)->nullable();
            $table->string("dir_fabricante", 255)->nullable();
            $table->string("num_identificacion", 255)->nullable();
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
        Schema::dropIfExists('repuestos');
    }
}
