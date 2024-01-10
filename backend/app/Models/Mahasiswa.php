<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class Mahasiswa extends Authenticatable
{

    use HasFactory, HasApiTokens, Notifiable;
    protected $table = 'mahasiswas';

    protected $fillable = [
        'nim', 'name', 'username', 'email', 'password', 'no_ktp', 'no_telp', 'google_id', 'role'
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $cast  = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function feeds(): HasMany
    {
        return  $this->hasMany(Feed::class);
    }

    public function booking(): HasMany
    {
        return $this->hasMany(Booking::class);
    }

    public function comments(): HasMany
    {
        return  $this->hasMany(Comment::class);
    }

    public function requestIK(): HasMany
    {
        return $this->hasMany(RequestIK::class);
    }

    public function requestIB(): HasMany
    {
        return $this->hasMany(IBRequest::class);
    }

    public function order(): HasMany
    {
        return $this->hasMany(Order::class);
    }

    public function carItems(): HasMany
    {
        return $this->hasMany(CartItem::class);
    }
    public function getMahasiswaName(): String
    {
        return $this->name;
    }
}
