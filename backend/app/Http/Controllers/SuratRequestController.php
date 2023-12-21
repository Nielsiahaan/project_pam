<?php

namespace App\Http\Controllers;

use App\Models\SuratRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class SuratRequestController extends Controller
{

    public function index()
    {
        try {
            $surats = SuratRequest::latest()->get();
            return response()->json(['data' => $surats], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengambil data surat.', 'error' => $e->getMessage()], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'content' => 'required|string',
                'kategori_surat' => 'required|string',
                'tanggal_pengambilan' => 'required|date',
            ]);

            $suratRequest = SuratRequest::create([
                'mahasiswa_id' => auth()->id(),
                'kategori_surat' => $request->input('kategori_surat'),
                'content' => $request->input('content'),
                'tanggal_pengambilan' => $request->input('tanggal_pengambilan'),
            ]);

            // Set status default 'pending'
            $suratRequest->status = 'pending';
            $suratRequest->save();

            $suratRequest->append('created_at_formatted');
            return response()->json(['message' => 'Surat berhasil diajukan.', 'data' => $suratRequest], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Gagal menyimpan surat.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menyimpan surat.', 'error' => $e->getMessage()], 500);
        }
    }

    public function update(Request $request, SuratRequest $suratRequest)
    {
        try {
            $validationRules = [
                'content' => 'required|string',
                'kategori_surat' => 'required|string',
                'tanggal_pengambilan' => 'required|date',
                'status' => 'in:pending,approved,rejected',
            ];

            $request->validate($validationRules);

            // Update status surat
            $suratRequest->fill([
                'content' => $request->input('content'),
                'kategori_surat' => $request->input('kategori_surat'),
                'tanggal_pengambilan' => $request->input('tanggal_pengambilan'),
                'status' => $request->input('status', $suratRequest->status),
                'mahasiswa_id' => auth()->id(),
            ]);

            $suratRequest->save();

            $suratRequest->append('created_at_formatted');
            return response()->json(['message' => 'Status surat berhasil diperbarui.', 'data' => $suratRequest], 200);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Gagal memperbarui surat.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal memperbarui surat.', 'error' => $e->getMessage()], 500);
        }
    }

    public function cancel($id)
    {
        try {
            $suratRequest = SuratRequest::findOrFail($id);
            if ($suratRequest->status !== 'pending') {
                return response()->json(['message' => 'Request Surat cant be cancelled'], 400);
            }

            $suratRequest->update(['status' =>
            'cancelled']);
            return response()->json(['message' => 'Request Surat cancelled successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to cancel Request Surat.', 'error' => $e->getMessage()], 500);
        }
    }
}
