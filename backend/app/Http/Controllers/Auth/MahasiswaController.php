<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Models\Mahasiswa;
use App\Notifications\ResetPasswordNotification;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;

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

    public function forgotPassword(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $user = Mahasiswa::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $token = $user->createToken('password-reset')->plainTextToken;
        $user->notify(new ResetPasswordNotification($token));

        return response()->json(['message' => 'Password reset link sent successfully']);
    }

    // public function resetPassword(Request $request)
    // {
    //     $request->validate([
    //         'email' => 'required|email',
    //         'password' => 'required|confirmed|min:8',
    //         'token' => 'required',
    //     ]);

    //     $status = Password::reset(
    //         $request->only('email', 'password', 'password_confirmation', 'token'),
    //         function ($user, $password) {
    //             $user->forceFill(['password' => bcrypt($password)])->save();
    //         }
    //     );

    //     return $status == Password::PASSWORD_RESET
    //         ? response()->json(['message' => trans($status)])
    //         : response()->json(['message' => trans($status)], 400);
    // }
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|confirmed|min:8',
            'token' => 'required',
        ]);

        $user = Mahasiswa::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) {
                $user->forceFill(['password' => bcrypt($password)])->save();
            }
        );

        if ($status == Password::PASSWORD_RESET) {
            // Perform additional actions after password reset, if needed
            // For example, log the user in automatically
            auth()->login($user);

            return response()->json(['message' => trans($status)]);
        } else {
            return response()->json(['message' => trans($status)], 400);
        }
    }

    protected function sendResetLinkResponse(Request $request, $response)
    {
        return response()->json(['message' => trans($response)]);
    }

    protected function sendResetLinkFailedResponse(Request $request, $response)
    {
        return response()->json(['error' => trans($response)], 400);
    }
}
