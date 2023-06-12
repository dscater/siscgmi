<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDetallePersonalsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_personals', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("orden_generada_id");
            $table->unsignedBigInteger("personal_id");
            $table->decimal("costo", 24, 2);
            $table->timestamps();

            $table->foreign("orden_generada_id")->on("orden_generadas")->references("id");
            $table->foreign("personal_id")->on("personals")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('detalle_personals');
    }
}
