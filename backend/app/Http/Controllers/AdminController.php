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
    public function getMahasiswa($id)
    {
        $mahasiswa = Mahasiswa::findOrFail($id);
        if ($mahasiswa) {
            $mahasiswaName = $mahasiswa->getMahasiswaName();

            return response(['mahasiswa' => $mahasiswaName], 200);
        } else {
            return response()->json(['message' => 'Mahasiswa not found'], 404);
        }
    }

    // request Ik controller
    public function getALlRequest()
    {
        try {
            $requestIK = RequestIK::latest()->paginate(null);
            return response(['request' => $requestIK], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengambil data Izin Keluar.', 'error' => $e->getMessage()]);
        }
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
            // $validatedData = request()->validate([
            //     'id' => 'integer|exists:request_i_k_s,id',
            // ]);
            $ikRequest = RequestIK::findOrFail($id);
            // Check if the status is not 'pending'
            if ($ikRequest->status !== 'pending') {
                return response()->json(['message' => 'Izin Keluar request status is not pending.'], 400);
            }
            // Update the status
            $ikRequest->update(['status' => $status]);

            return response()->json(['message' => "Izin Keluar request status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Failed to update Izin Keluar request status.', 'error' => $th->getMessage()], 500);
        }
    }

    // update status request surat controller

    public function getAllSurat()
    {
        $surats = SuratRequest::latest()->paginate(null);
        return response(['surats' => $surats], 200);
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
                return response()->json(['message' => 'Surat request\'s status is not pending.'], 400);
            }
            // Update the status
            $ikRequest->update(['status' => $status]);

            return response()->json(['message', "Surat request's status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Failed to update Surat request status.', 'error' => $th->getMessage()], 500);
        }
    }

    // update status izin bermalam
    public function getAllIzinBermalam()
    {
        $izinBermalam = IBRequest::latest()->get();
        return response(['izinBermalam' => $izinBermalam], 200);
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
                return response()->json(['message' => 'Surat request\'s status is not pending.'], 400);
            }
            // Update the status
            $ibRequest->update(['status' => $status]);

            return response()->json(['message', "Izin bermalam status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Failed to update Izin bermalam status.', 'error' => $th->getMessage()], 500);
        }
    }


    public function getAllBookingRoom()
    {
        try {
            $bookingRoom = BookingRequest::latest()->paginate(null);
            return response(['bookingRoom', $bookingRoom], 200);
        } catch (\Throwable $th) {
            return response(['message' => 'Failed to fetch booking information.', 'error' => $th->getMessage()], 500);
        }
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
            return response()->json(['message' => 'Failed to update booking room status.', 'error' => $th->getMessage()], 500);
        }
    }
}
