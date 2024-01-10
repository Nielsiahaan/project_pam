<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Tshirt extends Model
{
    use HasFactory;

    protected $fillable = [
        'size', 'price', 'quantity',
    ];

    public function orderItem(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public static function updateQuantity($size, $price, $quantity)
    {
        $tshirt = self::where('size', $size)
            ->where('price', $price)
            ->first();

        if ($tshirt) {
            $tshirt->quantity += $quantity;
            $tshirt->save();
        } else {
            $tshirt = self::create([
                'size' => $size,
                'price' => $price,
                'quantity' => $quantity,
            ]);
        }

        return $tshirt;
    }

    public function cartItems(): HasMany
    {
        return $this->hasMany(CartItem::class);
    }
}
