@extends('layouts.backend.main')
@section('title')
    Index Room
@endsection
@push('css')
    <link href="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.css" rel="stylesheet" />
@endpush
@push('js')
    <script src="https://cdn.datatables.net/v/bs5/dt-1.13.4/datatables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#cth').DataTable();
        });
    </script>
@endpush
@section('content')
    <div class="page-inner mt--5">
        <div class="row">
            <div class="col-md-12">
                <div class="card full-height">
                    <div class="card-header">
                        <div class="card-head-row d-flex">
                            <div class="card-title"><strong>{{ __('Rooms') }}</strong></div>
                            <a href="{{ route('room.create') }}" class="btn btn-primary btn-sm ml-auto"><i
                                    class="fa fa-plus"></i> {{ __('Add Room') }}</a>
                        </div>
                    </div>
                    <div class="card-body">
                        @if (session()->has('success'))
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>{{ session()->get('success') }}</strong>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <script>
                                // Membuat pesan success menghilang secara otomatis setelah 3 detik
                                setTimeout(function() {
                                    $('.alert-success').fadeOut('slow');
                                }, 2400);
                            </script>
                        @endif
                        <div class="table-responsive">
                            <table id="cth" class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th scope="col">No</th>
                                        <th scope="col">Nama Room</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($rooms as $row)
                                        <tr>
                                            <td>{{ $rooms->firstItem() + $loop->index }}</td>
                                            <td>{{ $row->roomName }} </td>
                                            <td>
                                                {{-- <button class="btn btn-success btn-sm modal-trigger" data-toggle="modal"
                                                    data-target="#myModal{{ $row->id }}"> <i
                                                        class="fas fa-eye"></i></button> --}}
                                                <a href="{{ route('room.edit', $row->id) }}"
                                                    class="btn btn-warning btn-sm me-2"><i class="fa fa-edit"></i></a>
                                                <form action="{{ route('room.destroy', $row->id) }}" method="post"
                                                    class="d-inline">
                                                    @csrf
                                                    @method('delete')
                                                    <button class="btn btn-danger btn-sm" id="btn-hapus"><i
                                                            class="fa fa-trash"></i></button>
                                                </form>
                                            </td>
                                        </tr>
                                    @empty
                                        <tr>
                                            <td colspan="3" class="text-center">{{ 'Data Masih Kosong' }}</td>
                                        </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
