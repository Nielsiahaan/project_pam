<?php

namespace App\Http\Controllers;

use App\Http\Requests\OrderRequest;
use App\Models\Order;
use App\Models\OrderItem;
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
            $orders = OrderItem::with('payment')->latest()->get();
            return response(['data' => $orders], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetching data orders.', 'error' => $e->getMessage()], 500);
        }
    }


    public function placeOrderAndMakePayment(int $tshirtId, Request $request)
    {
        try {
            // Validate input
            $validatedData = $request->validate([
                'tshirt_id' => 'exists:tshirts,id',
                'selected_size' => 'required|in:S,M,L,XL,XXL',
                'quantity' => 'required|numeric|min:1',
                'payment_method' => 'required|in:CreditCard,CashOnDelivery,Bank Transfer,DebitCard',
            ]);

            // Ambil data tshirt berdasarkan tshirt_id
            $tshirt = Tshirt::findOrFail($tshirtId);

            // Periksa apakah ukuran T-shirt yang dipilih sesuai
            if ($tshirt->size !== $validatedData['selected_size']) {
                return response()->json(['message' => 'Size selected does not match the product size'], 400);
            }

            // Hitung total harga
            $totalPrice = $tshirt->price * $validatedData['quantity'];

            // Step 3: Create order
            $order = Order::create([
                'mahasiswa_id' => auth()->id(),
                'total_price' => $totalPrice,
            ]);

            // Step 1: Create order item
            $orderItem = OrderItem::create([
                'order_id' => $order->id,
                'tshirt_id' => $tshirtId,
                'selected_size' => $validatedData['selected_size'],
                'quantity' => $validatedData['quantity'],
                'status' => 'Belum bayar',
            ]);

            // Step 2: Create payment
            $paymentAmount = $totalPrice;
            $payment = Payment::create([
                'order_item_id' => $orderItem->id,
                'payment_amount' => $paymentAmount,
                'payment_method' => $validatedData['payment_method'],
                'payment_status' => 'pending',
            ]);

            $orderItem->payment()->save($payment);

            // Save the order item after saving the payment
            $order->orderItem()->save($orderItem);

            return response()->json(['message' => 'Order placed and payment successful', 'order' => $order, 'order_item' => $orderItem, 'payment' => $payment], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Failed to place order and make payment.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to place order and make payment.', 'error' => $e->getMessage()], 500);
        }
    }


    public function cancelOrder(Request $request, $order_item_id)
    {
        try {
            $orderItem = OrderItem::with('payment')->findOrFail($order_item_id);

            // Check if the order is already canceled
            if ($orderItem->status == 'Canceled') {
                return response()->json(['message' => 'Order already canceled'], JsonResponse::HTTP_BAD_REQUEST);
            }

            // Check if the payment status is pending and order status is 'Belum bayar'
            if ($orderItem->payment && $orderItem->payment->payment_status == 'pending' && $orderItem->status == 'Belum bayar') {
                // Mark the order as canceled
                $orderItem->update(['status' => 'Canceled']);

                return response()->json(['message' => 'Order canceled successfully'], JsonResponse::HTTP_OK);
            }

            return response()->json(['message' => 'Order cannot be canceled. Payment status is already success or order status is not "Belum bayar"'], JsonResponse::HTTP_BAD_REQUEST);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to cancel order.'], JsonResponse::HTTP_INTERNAL_SERVER_ERROR);
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
}
