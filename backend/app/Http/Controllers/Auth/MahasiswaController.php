<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Models\Mahasiswa;
// use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class MahasiswaController extends Controller
{
    public function register(RegisterRequest $request)
    {
        $request->validated();
        $userData = [
            'nim' => $request->nim,
            'name' => $request->name,
            'username' => $request->username,
            'email' => $request->email,
            'no_ktp' => $request->no_ktp,
            'no_telp' => $request->no_telp,
            'password' => Hash::make($request->password),
        ];

        $user = Mahasiswa::create($userData);
        $token = $user->createToken('auth_token')->plainTextToken;
        return response([
            'user' => $user,
            'token' => $token,
        ], 201);
    }
    public function login(LoginRequest $request)
    {
        $request->validated();
        $user = Mahasiswa::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response(
                ['message' => 'Invalid credentials'],
                422
            );
        }

        $token = $user->createToken('auth_token')->plainTextToken;
        return response([
            'user' => $user,
            'token' => $token,
        ], 200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(
            [
                'message' => 'User successfully logged out',
            ],
            200
        );
    }
}
