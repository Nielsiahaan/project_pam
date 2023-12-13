<?php

namespace App\Http\Controllers;

use App\Http\Requests\IKRequest;
use App\Models\RequestIK;
use Illuminate\Http\Request;

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
                'status' => 'pending',
            ]);

            return response()->json(['message' => 'Izin Keluar Kampus berhasil diajukan.', 'data' => $ikRequest], 201);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Gagal melakukan request Izin Keluar Kampus.', 'error' => $th->getMessage()], 500);
        }
    }
    //     public function store(IKRequest $request)
    //     {
    //         try {
    //             $validatedData = $request->validated();

    //             // Check if tanggal_kembali is after tanggal_berangkat
    //             $tanggalBerangkat = \Carbon\Carbon::parse($validatedData['tanggal_berangkat']);
    //             $tanggalKembali = \Carbon\Carbon::parse($validatedData['tanggal_kembali']);

    //             if ($tanggalKembali->lte($tanggalBerangkat)) {
    //                 return response()->json(['message' => 'Tanggal kembali harus setelah tanggal berangkat.'], 400);
    //             }

    //             // Check if tanggal_berangkat is not in the past
    //             $now = \Carbon\Carbon::now();
    //             if ($tanggalBerangkat->lt($now)) {
    //                 return response()->json(['message' => 'Tanggal berangkat tidak boleh dari tanggal dan waktu sekarang.'], 400);
    //             }

    //             // Check if tanggal_kembali is not in the past
    //             if ($tanggalKembali->lt($now)) {
    //                 return response()->json(['message' => 'Tanggal kembali tidak boleh dari tanggal dan waktu sekarang.'], 400);
    //             }

    //             // create request ik
    //             $ikRequest = RequestIK::create([
    //                 'mahasiswa_id' => auth()->id(),
    //                 'tanggal_berangkat' => $validatedData['tanggal_berangkat'],
    //                 'tanggal_kembali' => $validatedData['tanggal_kembali'],
    //                 'deskripsi' => $validatedData['deskripsi'],
    //                 'status' => 'pending',
    //             ]);

    //             return response()->json(['message' => 'Izin Keluar Kampus berhasil diajukan.', 'data' => $ikRequest], 201);
    //         } catch (\Throwable $th) {
    //             return response()->json(['message' => 'Gagal melakukan request Izin Keluar Kampus.', 'error' => $th->getMessage()], 500);
    //         }
    //     }
    // }
}