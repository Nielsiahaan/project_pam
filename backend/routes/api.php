<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\Auth\MahasiswaController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\Feed\FeedController;
use App\Http\Controllers\GoogleController;
use App\Http\Controllers\IBRequestController;
use App\Http\Controllers\RequestIKController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\SuratRequestController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


// Route:apiResource();
Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('logout', [MahasiswaController::class, 'logout']);

    Route::post('feed/store', [FeedController::class, 'store']);
    Route::post('feed/like/{feed_id}', [FeedController::class, 'likePost']);
    Route::post('feed/comment/{feed_id}', [FeedController::class, 'comment']);
    Route::get('feed/comments/{feed_id}', [FeedController::class, 'getComments']);
    Route::get('feeds', [FeedController::class, 'index']);

    //route getMahasiswa
    Route::get('mahasiswa/{id}', [AdminController::class, 'getMahasiswa']);

    // room routes
    Route::apiResource('rooms', RoomController::class);

    //surat routes
    Route::apiResource('surat', SuratRequestController::class)->only(['index', 'store', 'update']);
    Route::put('surat/cancel/{id}', [SuratRequestController::class, 'cancel']);
    Route::put('approved_surat/{id}', [AdminController::class, 'approveSurat']);
    Route::put('rejected_surat/{id}', [AdminController::class, 'rejectSurat']);

    //Route booking
    Route::get('bookings', [BookingController::class, 'index']);
    Route::post('booking/store/{room_id}', [BookingController::class, 'store']);
    Route::put('booking/cancel/{id}', [BookingController::class, 'cancel']);

    //Route IK
    Route::apiResource('requestIK', RequestIKController::class)->only(['index', 'store']);
    Route::put('requestIK/cancel/{id}', [RequestIKController::class, 'cancel']);
    // Route::put('approve-status/{id}', [RequestIKController::class, 'approveStatus']);
    // Route::put('reject-status/{id}', [RequestIKController::class, 'rejectStatus']);

    //Route IB
    Route::apiResource('requestIB', IBRequestController::class)->only(['index', 'store']);
    Route::put('requestIB/cancel/{id}', [IBRequestController::class, 'cancel']);
});



Route::get('/test', function () {
    return response([
        'message' => 'Api is working'
    ], 200);
});

Route::post('register', [MahasiswaController::class, 'register']);
Route::post('login', [MahasiswaController::class, 'login']);

Route::controller(GoogleController::class)->group(function () {
    Route::get('auth/google', 'redirectToGoogle')->name('auth.google');
    Route::get('auth/google/callback', 'handleGoogleCallback');
});
