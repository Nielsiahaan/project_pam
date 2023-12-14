<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SuratRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'mahasiswa_id', 'content', 'status', 'kategori_surat', 'tanggal_pengambilan'
    ];
    protected $appends = ['created_at_formatted'];

    public function getCreatedAtFormattedAttribute()
    {
        return Carbon::parse($this->attributes['created_at'])->toDateTimeString();
    }

    public function mahasiswa(): BelongsTo
    {
        return $this->belongsTo(Mahasiswa::class, 'mahasiswa_id', 'id');
    }
}
