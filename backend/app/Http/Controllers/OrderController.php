<?php

namespace App\Http\Controllers;

use App\Http\Requests\OrderRequest;
use App\Models\CartItem;
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
            $mahasiswaId = auth()->id();
            $orders = Order::with('orderItem.tshirt', 'orderItem.payment')->where('mahasiswa_id', $mahasiswaId)->latest()->get();;
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
            if ($orderItem->status != 'Belum bayar') {
                $tshirt->quantity -= $validatedData['quantity'];
                $tshirt->save();
            }
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




    public function getCart()
    {
        try {
            $mahasiswaId = auth()->id();
            $cartItems = CartItem::with('tshirt')->where('mahasiswa_id', $mahasiswaId)->latest()->get();

            return response()->json(['data' => $cartItems], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to retrieve cart items.'], 500);
        }
    }


    public function addToCart(Request $request, int $tshirtId)
    {
        try {
            $validatedData = $request->validate([
                'size' => 'required|in:S,M,L,XL,XXL',
                'quantity' => 'required|numeric|min:1',
            ]);

            // Validate and fetch the Tshirt model
            $tshirt = Tshirt::find($tshirtId);

            if (!$tshirt) {
                return response()->json(['message' => 'Invalid T-shirt ID'], 400);
            }

            // Periksa apakah ukuran T-shirt yang dipilih sesuai
            if ($tshirt->size !== $validatedData['size']) {
                return response()->json(['message' => 'Size selected does not match the product size'], 400);
            }

            // Find existing cart item for the user, tshirt, and size
            $cartItem = CartItem::where([
                'mahasiswa_id' => auth()->id(),
                'tshirt_id' => $tshirtId,
                'size' => $validatedData['size'],
            ])->first();

            if ($cartItem) {
                // If T-shirt with the same size exists, increment the quantity
                $cartItem->update(['quantity' => $cartItem->quantity + $validatedData['quantity']]);
            } else {
                // Use the validated quantity
                $validatedData['mahasiswa_id'] = auth()->id();
                $validatedData['tshirt_id'] = $tshirtId; // Assign the correct tshirt_id
                CartItem::create($validatedData);
                $cartItem = CartItem::latest()->first();
            }

            // Customize the response data if needed
            $responseData = [
                'message' => 'T-shirt successfully added to the cart',
                'data' => [
                    'cart_item_id' => $cartItem->id,
                    'quantity' => $cartItem->quantity,
                ],
            ];

            return response()->json($responseData, 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to add T-shirt to the cart.'], 500);
        }
    }

    public function removeFromCart(Request $request, $tshirtId)
    {
        try {
            $user = auth()->id();

            // Find the cart item for the logged-in user
            $cartItem = CartItem::where('tshirt_id', $tshirtId)
                ->where('mahasiswa_id', $user)
                ->first();

            if (!$cartItem) {
                return response()->json(['message' => 'Item not found in the cart.'], 404);
            }

            // Update the cart item quantity
            $cartItem->quantity = $cartItem->quantity - $request->input('quantity', 1);

            // If the quantity becomes zero or negative, remove the item from the cart
            if ($cartItem->quantity <= 0) {
                $cartItem->delete();
            } else {
                $cartItem->save();
            }

            return response()->json(['message' => 'Item removed from the cart successfully.']);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to remove item from the cart.', 'error' => $e->getMessage()], 500);
        }
    }
}
