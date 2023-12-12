<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class IKRequest extends FormRequest
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
            'tanggal_berangkat' =>  'required|date_format:Y-m-d H:i:s',
            'tanggal_kembali' => 'required|date_format:Y-m-d H:i:s|after:tanggal_berangkat',
            'deskripsi' => 'required|string'
        ];
    }
}
