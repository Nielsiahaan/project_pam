<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('mahasiswa_id');
            $table->foreign('mahasiswa_id')->references('id')->on('mahasiswas');
            $table->unsignedBigInteger('tshirt_id');
            $table->foreign('tshirt_id')->references('id')->on('tshirts');
            $table->string('selected_size');
            $table->integer('quantity');
            $table->decimal('total_price');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
