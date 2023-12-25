<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Order extends Model
{
    use HasFactory;
    protected $fillable = ['mahasiswa_id', 'tshirt_id', 'selected_size', 'quantity', 'total_price'];

    public function tshirt(): BelongsTo
    {
        return $this->belongsTo(Tshirt::class);
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class);
    }

    public function mahasiswa(): BelongsTo{
        return $this->belongsTo(Mahasiswa::class, 'mahasiswa_id');
    }
}
