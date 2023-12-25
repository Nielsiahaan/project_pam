<?php

namespace App\Http\Controllers;

use App\Http\Requests\OrderRequest;
use App\Models\Order;
use App\Models\Payment;
use App\Models\Tshirt;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class OrderController extends Controller
{
    public function index()
    {
        try {
            $orders = Order::latest()->get();
            return response(['orders' => $orders], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetching data orders.', 'error' => $e->getMessage()], 500);
        }
    }

    public function getTshirtQuantities()
    {
        $tshirts = Tshirt::all();

        $formattedData = [];
        foreach ($tshirts as $tshirt) {
            if (!isset($formattedData[$tshirt->size])) {
                $formattedData[$tshirt->size] = [
                    'size' => $tshirt->size,
                    'total_quantity' => 0,
                ];
            }

            $formattedData[$tshirt->size]['total_quantity'] += $tshirt->quantity;
        }

        return response()->json(['tshirt_quantities' => array_values($formattedData)], 200);
    }



    public function placeOrder(Request $request, $tshirt_id)
    {
        try {
            $validatedData = $request->validate([
                'selected_size' => 'required|in:S,M,L,XL,XXL',
                'quantity' => 'required|numeric|min:1',
            ]);

            // Ambil data tshirt berdasarkan tshirt_id
            $tshirt = Tshirt::findOrFail($tshirt_id);

            // Periksa apakah size pada data tshirt sesuai dengan selected_size pada order
            if ($tshirt->size !== $validatedData['selected_size']) {
                return response()->json(['message' => 'Size selected does not match the product size'], 400);
            }

            // Hitung total harga
            $totalPrice = $tshirt->price * $validatedData['quantity'];

            // Buat order
            $order = Order::create([
                'mahasiswa_id' => auth()->id(),
                'tshirt_id' => $tshirt_id,
                'selected_size' => $validatedData['selected_size'],
                'quantity' => $validatedData['quantity'],
                'total_price' => $totalPrice,
            ]);

            // Kurangi jumlah stok pada data tshirt sesuai dengan quantity pada order
            $tshirt->quantity -= $validatedData['quantity'];
            $tshirt->save();

            return response()->json(['message' => 'Order placed successfully', 'order' => $order], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Failed to place order.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to place order.', 'error' => $e->getMessage()], 500);
        }
    }



    public function makePayment(Request $request, $order_id)
    {
        try {
            // Validate the request data
            $request->validate([
                'payment_method' => 'required|in:CreditCard,CashOnDelivery,Bank Transfer,DebitCard',
            ]);

            // Find the order
            $order = Order::findOrFail($order_id);

            // Check if the order is already paid
            if ($order->payment) {
                return response()->json(['message' => 'Payment already made for this order'], JsonResponse::HTTP_BAD_REQUEST);
            }

            // Use the total price from the order as the payment amount
            $paymentAmount = $order->total_price;

            // Create a payment for the order
            $payment = Payment::create([
                'order_id' => $order->id,
                'payment_amount' => $paymentAmount,
                'payment_method' => $request->input('payment_method'),
                'payment_status' => 'Success',
            ]);

            // Return success response with payment details
            return response()->json(['message' => 'Payment successful', 'payment' => $payment], JsonResponse::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to make payment.', 'error' => $e->getMessage()], 500);
        }
    }



    public function cancelOrder(Request $request, $order_id)
    {
        $order = Order::findOrFail($order_id);

        // Check if the order is already canceled
        if ($order->payment && $order->payment->payment_status == 'Canceled') {
            return response()->json(['message' => 'Order already canceled'], JsonResponse::HTTP_BAD_REQUEST);
        }

        // Check if the payment status pis 'Failure'
        if ($order->payment && $order->ayment->payment_status == 'Failure') {
            // Mark the order as canceled
            $order->update(['cancellation_status' => 'Canceled']);

            return response()->json(['message' => 'Order canceled successfully'], JsonResponse::HTTP_OK);
        }

        return response()->json(['message' => 'Order cannot be canceled. Payment status is already success"'], JsonResponse::HTTP_BAD_REQUEST);
    }
}
