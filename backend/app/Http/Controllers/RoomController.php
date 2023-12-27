<?php

namespace App\Http\Controllers;


use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class RoomController extends Controller
{
    public function index()
    {
        $rooms = Room::latest()->get();
        return response()->json(['data' => $rooms], 200);
    }

    public function show($roomId)
    {
        $room = Room::findOrFail($roomId);
        return response()->json(['data' => $room]);
    }

    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'roomName' => [
                    'required',
                    'string',
                    Rule::unique('rooms')->where(function ($query) use ($request) {
                        return $query->where('roomName', $request->input('roomName'));
                    }),
                ],
            ]);

            $room = Room::create($validatedData);

            return response()->json(['message' => 'Room berhasil ditambahkan.', 'data' => $room], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Gagal menambahkan ruangan.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menambahkan ruangan.'], 500);
        }
    }

    public function update(Request $request, $roomId)
    {
        try {
            $validatedData = $request->validate([
                'roomName' => [
                    'required',
                    'string',
                    Rule::unique('rooms')->ignore($roomId)->where(function ($query) use ($request) {
                        return $query->where('roomName', $request->input('roomName'));
                    }),
                ],
            ]);

            $room = Room::findOrFail($roomId);
            $room->update($validatedData);

            return response()->json(['message' => 'Room berhasil diperbarui.', 'data' => $room], 200);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Gagal memperbarui ruangan.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal memperbarui ruangan.'], 500);
        }
    }

    public function destroy($roomId)
    {
        try {
            $room = Room::findOrFail($roomId);
            $room->delete();

            return response()->json(['message' => 'Room berhasil dihapus.'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal menghapus ruangan.'], 500);
        }
    }
}
