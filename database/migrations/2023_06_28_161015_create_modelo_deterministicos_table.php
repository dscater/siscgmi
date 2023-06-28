<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateModeloDeterministicosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('modelo_deterministicos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255)->unique();
            $table->string("nombre", 255);
            $table->text("descripcion")->nullable();
            $table->unsignedBigInteger("repuesto_id");
            $table->decimal("sm", 24, 2)->nullable();
            $table->decimal("it", 24, 2)->nullable();
            $table->decimal("cpo", 24, 2)->nullable();
            $table->decimal("ct_ordenar", 24, 2)->nullable();
            $table->decimal("c_ins", 24, 2)->nullable();
            $table->decimal("c_em", 24, 2)->nullable();
            $table->decimal("c_ordenar", 24, 2)->nullable();
            $table->decimal("precio_compra", 24, 2)->nullable();
            $table->decimal("ct_adqui", 24, 2)->nullable();
            $table->decimal("c_impor", 24, 2)->nullable();
            $table->decimal("c_alma_ext", 24, 2)->nullable();
            $table->decimal("oc_adqui", 24, 2)->nullable();
            $table->decimal("c_adqui", 24, 2)->nullable();
            $table->decimal("c_alqui", 24, 2)->nullable();
            $table->double("area_ocupada", 24, 2)->nullable();
            $table->decimal("c_espa", 24, 2)->nullable();
            $table->decimal("vp_rep", 24, 2)->nullable();
            $table->double("cantp_rep", 24, 2)->nullable();
            $table->decimal("costop_rep", 24, 2)->nullable();
            $table->decimal("tasa_ia", 24, 2)->nullable();
            $table->decimal("costo_capital", 24, 2)->nullable();
            $table->decimal("ct_almacenamiento", 24, 2)->nullable();
            $table->decimal("c_depreciacion", 24, 2)->nullable();
            $table->decimal("c_gi", 24, 2)->nullable();
            $table->decimal("oc_mantenimiento", 24, 2)->nullable();
            $table->decimal("c_mantenimiento", 24, 2)->nullable();
            $table->decimal("leadtime", 24, 2)->nullable();
            $table->double("procesamiento_pedido", 24, 2)->nullable();
            $table->double("fabricacion_productos", 24, 2)->nullable();
            $table->double("tiempo_transito", 24, 2)->nullable();
            $table->double("inspeccion_control", 24, 2)->nullable();
            $table->double("unidad", 24, 2)->nullable();
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
        Schema::dropIfExists('modelo_deterministicos');
    }
}
