@extends('layouts.backend.main')
@section('title')
    Create Room
@endsection
@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card full-height">
                    <div class="card-header">
                        <div class="card-head-row d-flex">
                            <div class="card-title">{{ __('Form Room') }}</div>
                            <a href="{{ route('room.index') }}" class="btn btn-warning btn-sm ml-auto"><i
                                    class="fa fa-backward"></i></a>
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="{{ route('room.store') }}" method="post" enctype="multipart/form-data">
                            @csrf
                            <div class="mb-3">
                                <label for="judul" class="form-label">{{ __('Judul Artikel') }}</label><span
                                    aria-hidden="true" role="presentation" class="field_required"
                                    style="color:#ee0000;">*</span>
                                <input type="text" name="roomName" class="form-control" id="roomName"
                                    placeholder="Enter room name">
                                @error('roomName')
                                    <span class="text-danger mt-2">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-primary btn-sm" type="submit">{{ __('Create') }}</button>
                                <button class="btn btn-danger btn-sm" type="reset">{{ __('Reset') }}</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
