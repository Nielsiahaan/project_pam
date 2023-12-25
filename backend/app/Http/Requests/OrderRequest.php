<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class OrderRequest extends FormRequest
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
            'mahasiswa_id' => 'exists:mahasiswas,id',
            'tshirt_id' => 'exists:tshirts,id',
            'selected_size' => 'required|in:S,M,L,XL,XXL',
            'quantity' => 'required|integer|min:1|available_quantity:' . $this->route('tshirt_id'),
        ];
    }
}
