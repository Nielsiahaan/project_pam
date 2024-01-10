<?php

namespace App\Http\Controllers;

use App\Http\Requests\BookingRequest;
use App\Models\Booking;
use App\Models\IBRequest;
use App\Models\Mahasiswa;
use App\Models\OrderItem;
use App\Models\RequestIK;
use App\Models\SuratRequest;
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

    // update Status IK

    public function approveIK($id)
    {
        return $this->updateStatusIK($id, 'approved');
    }

    public function rejectIK($id)
    {
        return $this->updateStatusIK($id, 'rejected');
    }


    public function updateStatusIK($id, $status)
    {
        try {
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



    // update status request surat


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

            return response()->json(['message' => "Surat request's status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Failed to update Surat request status.', 'error' => $th->getMessage()], 500);
        }
    }

    // update status IB

    public function approveIB($id)
    {
        return $this->updateStatusIB($id, 'approved');
    }

    public function rejectIB($id)
    {
        return $this->updateStatusIB($id, 'rejected');
    }
    public function updateStatusIB($id, $status)
    {
        try {

            $ibRequest = IBRequest::findOrFail($id);
            // Check if the status is not 'pending'
            if ($ibRequest->status !== 'pending') {
                return response()->json(['message' => 'IB request\'s status is not pending.'], 400);
            }
            // Update the status
            $ibRequest->update(['status' => $status]);

            return response()->json(['message' => "Izin bermalam status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Failed to update Izin bermalam status.', 'error' => $th->getMessage()], 500);
        }
    }

    // update status booking room

    public function approveBookingRoom($id)
    {
        return $this->updateStatusBookingRoom($id, 'approved');
    }

    public function rejectBookingRoom($id)
    {
        return $this->updateStatusBookingRoom($id, 'rejected');
    }

    public function updateStatusBookingRoom($id, $status)
    {
        try {
            $bookingRoom = Booking::findOrFail($id);
            if ($bookingRoom->status !==  'pending') {
                return response()->json(['message' => 'Booking Room\'s status is not pending.'], 400);
            }

            $bookingRoom->update([
                'status' => $status
            ]);
            return response()->json(['message' => "Booking status successfully updated to '$status'."], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Failed to update booking room status.', 'error' => $th->getMessage()], 500);
        }
    }

    public function approveOrderItem(int $orderItemId)
    {
        $orderItem = OrderItem::findOrFail($orderItemId);
        $orderItem->setStatus('Sukses');
    }

}
