<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Izin;
use Carbon\Carbon;

class IzinController extends Controller
{
    public function requestKeluar(Request $request)
    {
        $this->validateRequestKeluar($request);

        // Simpan data izin keluar
        $izin = Izin::create([
            'meta_key' => uniqid(),
            'tanggal_berangkat' => $request->input('tanggal_berangkat'),
            'tanggal_kembali' => null,
            'deskripsi' => $request->input('deskripsi'),
            'tujuan' => null,
            'status_request' => 'pending',
        ]);

        // Proses approval jika diperlukan

        return response()->json(['message' => 'Izin keluar berhasil diajukan']);
    }

    public function requestBermalam(Request $request)
    {
        $this->validateRequestBermalam($request);

        $izin = Izin::create([
            'mahasiswa_id' => auth()->id(),
            'meta_key' => uniqid(),
            'tanggal_berangkat' => $request->input('tanggal_berangkat'),
            'tanggal_kembali' => $request->input('tanggal_kembali'),
            'deskripsi' => $request->input('deskripsi'),
            'tujuan' => $request->input('tujuan'),
            'status_request' => 'pending',
        ]);

        // Proses approval jika diperlukan

        return response()->json(['message' => 'Izin bermalam berhasil diajukan', 'data' => $izin]);
    }

    protected function validateRequestKeluar(Request $request)
    {
        $validatedData = $request->validate([
            'tanggal_berangkat' => 'required|date',
            'deskripsi' => 'required|string',
        ]);

        // Tambahan validasi khusus untuk request keluar jika diperlukan
    }

    protected function validateRequestBermalam(Request $request)
    {
        $validatedData = $request->validate([
            'tanggal_berangkat' => 'required|date',
            'tanggal_kembali' => 'required|date',
            'deskripsi' => 'required|string',
            'tujuan' => 'required|string',
        ]);

        // Validasi waktu untuk izin bermalam
        $this->validateWaktuBermalam($request->input('tanggal_berangkat'));
    }

    protected function validateWaktuBermalam($tanggalBerangkat)
    {
        $tanggal = Carbon::parse($tanggalBerangkat);
        $dayOfWeek = $tanggal->dayOfWeek;
        $jamSekarang = Carbon::now()->format('H:i:s');

        // Izin bermalam hanya bisa direquest pada hari Jumat di atas jam 17.00 dan hari Sabtu (08.00 – 17.00)
        if (($dayOfWeek == Carbon::FRIDAY && $jamSekarang > '17:00:00') || ($dayOfWeek == Carbon::SATURDAY && $jamSekarang >= '08:00:00' && $jamSekarang <= '17:00:00')) {
            return;
        }

        // Jika tidak memenuhi kondisi di atas, throw exception atau handle sesuai kebutuhan
        throw new \Exception('Izin bermalam hanya bisa direquest pada hari Jumat di atas jam 17.00 dan hari Sabtu (08.00 – 17.00).');
    }
}
