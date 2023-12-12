<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }


    public function rules(): array
    {
        return [
            'nim' => 'required|min:8',
            'name' => 'required|min:4',
            'username' => 'required|string|min:4|unique:mahasiswas',
            'email' => 'required|email|unique:mahasiswas',
            'no_ktp' => 'required|min:16',
            'password' => 'required|min:6',
            'no_telp' => 'required|min:12'
        ];
    }
}
