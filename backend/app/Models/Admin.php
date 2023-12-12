<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Admin extends Authenticatable
{
    use HasFactory, HasApiTokens, Notifiable;
    protected $table  = 'admins';

    protected $fillable = ['username, email, password'];

    protected $hidden = ['password, remember_token'];

    protected $cast = ['email_verified_at' => 'datetime', 'password' => 'hashed'];
}
