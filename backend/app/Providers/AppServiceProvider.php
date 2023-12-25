<?php

namespace App\Providers;

use App\Models\Tshirt;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot()
    {
        Validator::extend('available_quantity', function ($attribute, $value, $parameters, $validator) {
            // Check if the requested quantity is available in the selected size
            $selectedSize = $validator->getData()['selected_size'];
            $tshirtId = $parameters[0];

            // Retrieve T-shirt details
            $tshirt = Tshirt::findOrFail($tshirtId);
            $availableQuantity = $tshirt['quantity_' . strtolower($selectedSize)];

            return $value <= $availableQuantity;
        });
    }
}
