<?php

namespace App\Http\Controllers;

use App\Models\IBRequest;
use Carbon\Carbon;
use Illuminate\Http\Request;

class IBRequestController extends Controller
{
    public function index()
    {
        try {
            $requestIB = IBRequest::with('mahasiswa')->latest()->get();
            return response(['requestIB' => $requestIB], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengambil data request IB', 'error' => $e->getMessage()], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            // Validate the timing conditions for IB requests
            $this->validateRequestBermalam($request);

            //call validate method waktu bermalam
            $this->validateWaktuBermalam($request->input('tanggal_berangkat'));

            // Simpan data izin bermalam
            $izin = IBRequest::create([
                'mahasiswa_id' => auth()->id(),
                'tanggal_berangkat' => $request->input('tanggal_berangkat'),
                'tanggal_kembali' => $request->input('tanggal_kembali'),
                'deskripsi' => $request->input('deskripsi'),
                'tujuan' => $request->input('tujuan'),

            ]);
            return response()->json([
                'message' => 'Izin bermalam berhasil diajukan', 'data' => $izin
            ], 201);
        } catch (\Throwable $th) {
            // Log the error
            // \Illuminate\Support\Facades\Log::error($th);
            return response()->json(['message' => 'Gagal melakukan request Izin Bermalam.', 'error' => $th->getMessage()], 500);
        }
    }

    protected function validateRequestBermalam(Request $request)
    {
        $validatedData = $request->validate([
            'tanggal_berangkat' =>  'required|date_format:Y-m-d H:i:s',
            'tanggal_kembali' => 'required|date_format:Y-m-d H:i:s|after:tanggal_berangkat',
            'deskripsi' => 'required|string',
            'tujuan' => 'required|string'
        ]);
    }

    protected function validateWaktuBermalam($tanggalBerangkat)
    {
        $tanggal = Carbon::parse($tanggalBerangkat);
        $dayOfWeek = $tanggal->dayOfWeekIso;

        // Check if the day of the week is Friday (5) and the time is after 17:00
        // or if it's Saturday (6) between 08:00 and 17:00
        if (($dayOfWeek == Carbon::FRIDAY && $tanggal->format('H:i:s') > '17:00:00') ||
            ($dayOfWeek == Carbon::SATURDAY && $tanggal->format('H:i:s') >= '08:00:00' && $tanggal->format('H:i:s') <= '17:00:00')
        ) {
            return;
        }

        // Jika tidak memenuhi kondisi di atas, throw exception atau handle sesuai kebutuhan
        throw new \Exception('Izin bermalam hanya bisa direquest pada hari Jumat di atas jam 17.00 dan hari Sabtu (08.00 – 17.00).');
    }
}
