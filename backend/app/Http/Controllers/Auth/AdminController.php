<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email|unique:admins',
            'username' => 'required|string|min:4',
            'password' => 'required|min:6',
        ]);

        $admin = Admin::where('email', $request->email)->first();
        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response([
                'message' => 'Invalid credentials',
            ], 422);
        }

        $token = $admin->createToken('auth_token')->plainTextToken;
        return response([
            'admin' => $admin,
            'token' => $token
        ], 200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(
            ['message' => 'Logged out',],
            200
        );
    }
}
