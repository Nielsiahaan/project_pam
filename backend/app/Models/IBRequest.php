<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class IBRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'mahasiswa_id', 'tanggal_berangkat', 'tanggal_kembali', 'deskripsi', 'tujuan', 'status'
    ];

    public function mahasiswa(): BelongsTo
    {
        return $this->belongsTo(Mahasiswa::class, 'mahasiswa_id', 'id');
    }
}
