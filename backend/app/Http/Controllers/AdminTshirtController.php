<?php

namespace App\Http\Controllers;

use App\Http\Requests\TshirtRequest;
use App\Models\Tshirt;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AdminTshirtController extends Controller
{
    public function index()
    {
        $tshirts = Tshirt::latest()->get();
        return response(['data' => $tshirts], 200);
    }

    public function store(TshirtRequest $request)
    {
        try {
            $validatedData = $request->validated();


            $tshirt = Tshirt::updateQuantity(
                $validatedData['size'],
                $validatedData['price'],
                $validatedData['quantity']
            );

            return response()->json(['message' => 'T-shirt created successfully', 'data' => $tshirt], 201);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Failed to add T-shirt.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to add T-shirt.'], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $validatedData  = $request->validate(
                [
                    'size' => 'required|in:S,M,L,XL,XXL',
                    'price' => 'required|numeric|min:0',
                    'quantity' => 'required|numeric|min:0',
                ]
            );

            $tshirt = Tshirt::findOrFail($id);

            // check if tshirt is not found
            if (!$tshirt) {
                return response()->json(['message' => 'T-shirt not found'], 404);
            }

            $tshirt->update([
                'size' => $validatedData['size'],
                'price' => $validatedData['price'],
                'quantity' => $validatedData['quantity'],
            ]);

            return response()->json(['message' => 'T-shirt updated successfully', 'data' => $tshirt], 200);
        } catch (ValidationException $e) {
            return response()->json(['message' => 'Failed to update T-shirt.', 'errors' => $e->errors()], 400);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update T-shirt.'], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $tshirt = Tshirt::findOrFail($id);

            if (!$tshirt) {
                return response()->json(['message' => 'T-shirt not found'], JsonResponse::HTTP_NOT_FOUND);
            }

            $tshirt->delete();

            return response()->json(['message' => 'T-shirt deleted successfully'], JsonResponse::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete T-shirt.'], 500);
        }
    }
}
