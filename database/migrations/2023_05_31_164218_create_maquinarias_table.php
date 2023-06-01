<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMaquinariasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('maquinarias', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("equipo_id");
            $table->text("descripcion");
            $table->string("prioridad");
            $table->string("ubicacion");
            $table->string("tipo");
            $table->string("marca")->nullable();
            $table->string("modelo")->nullable();
            $table->string("serie")->nullable();
            $table->decimal("costo", 24, 2)->nullable();
            $table->date("fecha_compra")->nullable();
            $table->date("fecha_instalacion")->nullable();
            $table->double("garantia_meses")->nullable();
            $table->string("peso")->nullable();
            $table->string("altura")->nullable();
            $table->string("ancho")->nullable();
            $table->string("largo")->nullable();
            $table->string("voltios")->nullable();
            $table->string("capacidad")->nullable();
            $table->string("e_tecnicas")->nullable();
            $table->date("fecha_ultimo_mantenimiento")->nullable();
            $table->date("fecha_utlimo_termino")->nullable();
            $table->string("estado")->nullable();
            $table->string("fabricantes", 255)->nullable();
            $table->string("proveedor", 255)->nullable();
            $table->string("terciarios", 255)->nullable();
            $table->string("nombre_contacto", 255)->nullable();
            $table->string("num_fono", 255)->nullable();
            $table->string("correo", 255)->nullable();
            $table->string("dir", 255)->nullable();
            $table->string("num_identificacion", 255)->nullable();
            $table->string("foto", 255)->nullable();
            $table->string("archivo", 255)->nullable();
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
        Schema::dropIfExists('maquinarias');
    }
}
