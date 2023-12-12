<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Feed extends Model
{
    use HasFactory;
    protected $fillable = [
        'mahasiswa_id', 'content'
    ];

    protected $appends = ['liked'];
    public function mahasiswa(): BelongsTo
    {
        return $this->belongsTo(Mahasiswa::class, 'mahasiswa_id');
    }

    public function likes(): HasMany
    {
        return $this->hasMany(Like::class);
    }

    public function getLikedAttribute(): bool
    {
        return (bool) $this->likes()->where('feed_id', $this->id)->where('mahasiswa_id', auth()->id())->exists();
    }

    public function comments(): HasMany
    {
        return $this->hasMany(Comment::class);
    }
}
