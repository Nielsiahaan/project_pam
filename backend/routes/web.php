<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::view('/', 'auth.login')->name('login');
Route::get('dashboard', [AuthenticatedSessionController::class, 'dashboard'])->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::resource('room', RoomController::class);

    //route request ik
    Route::get('requestIk', [AdminController::class, 'getAllRequest'])->name('requestIk.index');
    Route::put('approve-status/{id}', [AdminController::class, 'approveStatus'])->name('approve_status');
    Route::put('reject-status/{id}', [AdminController::class, 'rejectStatus'])->name('reject_status');

    //route request surat
    Route::get('requestSurat', [AdminController::class, 'getAllSurat'])->name('requestSurat.index');
    Route::put('suratApprove/{id}', [AdminController::class, 'approveSurat'])->name('approve_surat');
    Route::put('suratReject/{id}', [AdminController::class, 'rejectSurat'])->name('reject_surat');

    //route request ib
    Route::get('requestIB', [AdminController::class, 'getAllIzinBermalam'])->name('requestIB.index');
    Route::put('IBApprove/{id}', [AdminController::class, 'approveIzinBermalam'])->name('approve_IzinBermalam');
    Route::put('IBReject/{id}', [AdminController::class, 'rejectIzinBermalam'])->name('reject_IzinBermalam');

    Route::get('AllBookingRoom', [AdminController::class, 'getAllBookingRoom'])->name('bookingRoom.index');
    Route::put('approveBookingRoom/{id}', [AdminController::class, 'approveBooking'])->name('approveBooking');
});

require __DIR__ . '/auth.php';
