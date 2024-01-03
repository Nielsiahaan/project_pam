<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class OrderItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'order_id', 'tshirt_id', 'selected_size', 'quantity', 'status', 'proof_of_payment'
    ];


    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function tshirt(): BelongsTo
    {
        return $this->belongsTo(Tshirt::class);
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class);
    }

    public function setStatus($status)
    {
        $this->status = $status;
        $this->save();
    }
}
