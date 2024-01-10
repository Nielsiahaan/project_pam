<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AdminTshirtController;
use App\Http\Controllers\Auth\MahasiswaController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\Feed\FeedController;
use App\Http\Controllers\GoogleController;
use App\Http\Controllers\IBRequestController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\RequestIKController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\SuratRequestController;
use Illuminate\Support\Facades\Route;


// Route:apiResource();
Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('logout', [MahasiswaController::class, 'logout']);

    // Routes Feed
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

    //Routes booking room
    Route::get('bookings', [BookingController::class, 'index']);
    Route::post('booking/store/{room_id}', [BookingController::class, 'store']);
    Route::put('booking/cancel/{id}', [BookingController::class, 'cancel']);
    Route::put('approved_room/{id}', [AdminController::class, 'approveBookingRoom']);
    Route::put('rejected_room/{id}', [AdminController::class, 'rejectBookingRoom']);

    //Routes IK
    Route::apiResource('requestIK', RequestIKController::class)->only(['index', 'store']);
    Route::put('requestIK/cancel/{id}', [RequestIKController::class, 'cancel']);
    Route::put('approved_ik/{id}', [AdminController::class, 'approveIK']);
    Route::put('rejected_ik/{id}', [AdminController::class, 'rejectIK']);

    //Routes IB
    Route::apiResource('requestIB', IBRequestController::class)->only(['index', 'store']);
    Route::put('requestIB/cancel/{id}', [IBRequestController::class, 'cancel']);
    Route::put('approved_ib/{id}', [AdminController::class, 'approveIB']);
    Route::put('rejected_ib/{id}', [AdminController::class, 'rejectIB']);

    //Route t-shirt
    Route::apiResource('tshirt', AdminTshirtController::class);
    Route::get('tshirt-quantities', [AdminTshirtController::class, 'getTshirtQuantities']);


    //Routes order t-shirt
    Route::get('orders-tshirt', [OrderController::class, 'index']);
    Route::post('place-order-and-make-payment/{tshirt_id}', [OrderController::class, 'placeOrderAndMakePayment']);
    Route::post('add-to-cart/{tshirt_id}', [OrderController::class, 'addToCart']);
    Route::post('remove-from-cart/{tshirt_id}', [OrderController::class, 'removeFromCart']);
    Route::get('get-cart', [OrderController::class, 'getCart']);
    Route::put('orders/cancel/{id}', [OrderController::class, 'cancelOrder']);
});

// Routes Authentication
Route::post('register', [MahasiswaController::class, 'register']);
Route::post('login', [MahasiswaController::class, 'login']);
Route::post('forgot-password', [MahasiswaController::class, 'forgotPassword']);
Route::post('reset-password', [MahasiswaController::class, 'resetPassword']);


Route::controller(GoogleController::class)->group(function () {
    Route::get('auth/google', 'redirectToGoogle')->name('auth.google');
    Route::get('auth/google/callback', 'handleGoogleCallback');
});
