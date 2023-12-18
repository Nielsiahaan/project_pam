<?php

namespace App\Http\Controllers;

use App\Http\Requests\BookingRequest;
use App\Models\IBRequest;
use App\Models\Mahasiswa;
use App\Models\RequestIK;
use App\Models\SuratRequest;
use Illuminate\Http\Request;
use Psy\CodeCleaner\FunctionContextPass;

class AdminController extends Controller
{
    // request Ik controller
    public function getALlRequest()
    {
        $requestIK = RequestIK::latest()->paginate(null);
        $mahasiswa =  Mahasiswa::get();
        return view('admin.requestIK.index', compact('requestIK', 'mahasiswa'));
    }
    public function approveStatus($id)
    {
        return $this->updateStatus($id, 'approved');
    }

    public function rejectStatus($id)
    {
        return $this->updateStatus($id, 'rejected');
    }


    public function updateStatus($id, $status)
    {
        try {

            $validatedData = request()->validate([
                'id' => 'integer|exists:request_i_k_s,id',
            ]);
            $ikRequest = RequestIK::findOrFail($id);
            // Check if the status is not 'pending'
            if ($ikRequest->status !== 'pending') {
                return redirect()->route('requestIk.index')->with('error', 'Status permintaan izin keluar sudah tidak dalam status pending.');
            }
            // Update the status
            $ikRequest->update(['status' => $status]);

            return redirect()->route('requestIk.index')->with('success', "Status permintaan izin keluar berhasil diubah menjadi '$status'.");
        } catch (\Throwable $th) {

            return redirect()->route('requestIk.index')->with('error', 'Gagal mengubah status permintaan izin keluar.');
        }
    }

    // request surat controller

    public function getAllSurat()
    {
        $surats = SuratRequest::latest()->paginate(null);
        $mahasiswa = Mahasiswa::get();
        return view('admin.requestSurat.index', compact('surats', 'mahasiswa'));
    }

    public function approveSurat($id)
    {
        return $this->updateStatusSurat($id, 'approved');
    }

    public function rejectSurat($id)
    {
        return $this->updateStatusSurat($id, 'rejected');
    }
    public function updateStatusSurat($id, $status)
    {
        try {
            $ikRequest = SuratRequest::findOrFail($id);

            // Check if the status is not 'pending'
            if ($ikRequest->status !== 'pending') {
                return redirect()->route('requestSurat.index')->with('error', 'Status permintaan izin keluar sudah tidak dalam status pending.');
            }
            // Update the status
            $ikRequest->update(['status' => $status]);

            return redirect()->route('requestSurat.index')->with('success', "Status permintaan izin keluar berhasil diubah menjadi '$status'.");
        } catch (\Throwable $th) {

            return redirect()->route('requestSurat.index')->with('error', 'Gagal mengubah status permintaan izin keluar.');
        }
    }
    public function getAllIzinBermalam()
    {
        $izinBermalam = IBRequest::latest()->paginate(null);
        $mahasiswa = Mahasiswa::get();
        return view('admin.requestIB.index', compact('izinBermalam', 'mahasiswa'));
    }

    public function approveIzinBermalam($id)
    {
        return $this->updateStatusIzinBermalam($id, 'approved');
    }

    public function rejectIzinBermalam($id)
    {
        return $this->updateStatusIzinBermalam($id, 'rejected');
    }
    public function updateStatusIzinBermalam($id, $status)
    {
        try {

            $ibRequest = IBRequest::findOrFail($id);
            // Check if the status is not 'pending'
            if ($ibRequest->status !== 'pending') {
                return redirect()->route('requestIB.index')->with('error', 'Status permintaan izin keluar sudah tidak dalam status pending.');
            }
            // Update the status
            $ibRequest->update(['status' => $status]);

            return redirect()->route('requestIB.index')->with('success', "Status permintaan izin keluar berhasil diubah menjadi '$status'.");
        } catch (\Throwable $th) {

            return redirect()->route('requestIB.index ')->with('error', 'Gagal mengubah status permintaan izin keluar.');
        }
    }


    public function getAllBookingRoom()
    {
        $bookingRoom = BookingRequest::latest()->paginate(null);
        $mahasiswa = Mahasiswa::get();
        return view('admin.bookingRoom.index', compact('bookingRoom', 'mahasiswa'));
    }

    public function updateStatusBookingRoom($id, $status)
    {
        try {
            $bookingRoom = BookingRequest::findOrFail($id);
            if ($bookingRoom->status !==  'pending') {
                return redirect()->route('bookingRoom.index')->with('error', 'Status pemesanan ruangan sudah tidak pending lagi');
            }

            $bookingRoom->update([
                'status' => $status
            ]);
            return redirect()->route('bookingRoom.index')->with(
                'success',
                "Status pemesanan ruangan berhasil diubah menjadi '$status'"
            );
        } catch (\Throwable $th) {
        }
    }
}
