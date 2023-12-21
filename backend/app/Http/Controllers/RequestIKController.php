<?php

namespace App\Http\Controllers;

use App\Http\Requests\IKRequest;
use App\Models\RequestIK;
use Illuminate\Database\Eloquent\Casts\Json;

class RequestIKController extends Controller
{
    public function index()
    {
        try {
            $requestIK = RequestIK::with('mahasiswa')->latest()->get();
            return response(['requestIk' => $requestIK], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengambil data request IK,', 'error' => $e->getMessage()], 500);
        }
    }

    public function store(IKRequest $request)
    {
        try {
            $validatedData = $request->validated();

            // Check if tanggal_kembali is after tanggal_berangkat
            $tanggalBerangkat = \Carbon\Carbon::parse($validatedData['tanggal_berangkat']);
            $tanggalKembali = \Carbon\Carbon::parse($validatedData['tanggal_kembali']);

            if ($tanggalKembali->lte($tanggalBerangkat)) {
                return response()->json(['message' => 'Tanggal kembali harus setelah tanggal berangkat.'], 400);
            }

            // create request ik
            $ikRequest = RequestIK::create([
                'mahasiswa_id' => auth()->id(),
                'tanggal_berangkat' => $validatedData['tanggal_berangkat'],
                'tanggal_kembali' => $validatedData['tanggal_kembali'],
                'deskripsi' => $validatedData['deskripsi'],

            ]);

            return response()->json(['message' => 'Izin Keluar Kampus berhasil diajukan.', 'data' => $ikRequest], 201);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Gagal melakukan request Izin Keluar Kampus.', 'error' => $th->getMessage()], 500);
        }
    }


    public function cancel($id)
    {
        try {
            $ikRequest = RequestIK::findOrFail($id);
            if ($ikRequest->status !== 'pending') {
                return response()->json(['message' => 'Izin Keluar can\'t be cancelled.'], 400);
            }
            $ikRequest->update(['status' => 'cancelled']);
            return response()->json(['message' => 'Izin Keluar cancelled successfully.'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to cancel Izin Keluar.', 'error' => $e->getMessage()], 500);
        }
    }
}
