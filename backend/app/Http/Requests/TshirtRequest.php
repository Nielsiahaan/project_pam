<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TshirtRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'size' => 'required|in:S,M,L,XL,XXL|unique:tshirts',
            'price' => 'required|numeric|min:0',
            'quantity' => 'required|numeric|min:0',
        ];
    }
}
