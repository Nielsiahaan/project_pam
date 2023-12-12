@extends('layouts.backend.main')
@section('title')
    Edit Room
@endsection
@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header">
                        <div class="card-head-row d-flex">
                            <div class="card-title">Edit Room</div>
                            <a href="{{ route('room.index') }}" class="btn btn-warning btn-sm ml-auto"><i
                                    class="fa fa-backward"></i></a>
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="{{ route('room.update', $room->id) }}" method="post" enctype="multipart/form-data">
                            @csrf
                            @method('put')
                            <div class="mb-3">
                                <label for="roomName" class="form-label">{{ __('Nama Room') }}</label><span
                                    aria-hidden="true" role="presentation" class="field_required"
                                    style="color:#ee0000;">*</span>
                                <input type="text" name="roomName" class="form-control" id="judul"
                                    value="{{ $room->roomName }}">
                                @error('judul')
                                    <span class="text-danger mt-2">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="mb-3">
                                <button class="btn btn-primary btn-sm" type="submit">{{ __('Update') }}</button>
                                <a id="btn-batal" href="{{ route('room.index') }}"
                                    class="btn btn-danger btn-sm">{{ __('Batal') }}</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
