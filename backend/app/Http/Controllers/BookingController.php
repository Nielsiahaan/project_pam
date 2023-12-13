<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Requests\BookingRequest;
use App\Models\Booking;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class BookingController extends Controller
{
    public function index()
    {
        try {
            $bookings = Booking::with('mahasiswa')->latest()->get();
            return response(['bookings' => $bookings], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengambil data booking.', 'error' => $e->getMessage()], 500);
        }
    }

    public function store(BookingRequest $request, $room_Id)
    {
        try {
            $validatedData = $request->validated();

            $isRoomAvailable = Booking::where('room_id', $room_Id)
                ->where(function ($query) use ($validatedData) {
                    $query->whereBetween('start_time', [$validatedData['start_time'], $validatedData['end_time']])
                        ->orWhereBetween('end_time', [$validatedData['start_time'], $validatedData['end_time']]);
                })->doesntExist();

            if (!$isRoomAvailable) {
                return response()->json(['message' => 'Ruangan tidak tersedia, ruangan telah dipesan.'], 400);
            }

            $booking = Booking::create([
                'mahasiswa_id' => auth()->id(),
                'room_id' => $room_Id,
                'start_time' => $validatedData['start_time'],
                'end_time' => $validatedData['end_time'],
                'keterangan' => $validatedData['keterangan'],
            ]);

            return response()->json(['message' => 'Ruangan berhasil di-book.', 'data' => $booking], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Gagal melakukan booking ruangan.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal melakukan booking ruangan.', 'error' => $e->getMessage()], 500);
        }
    }
}