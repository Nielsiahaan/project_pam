@extends('layouts.backend.main')
@section('title')
    Index Request Surat
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
                            <div class="card-title"><strong>{{ __('Request IK') }}</strong></div>
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
                                        <th scope="col">Nama Mahasiswa</th>
                                        <th scope="col">Kategori Surat</th>
                                        <th scope="col">Deskripsi Surat</th>
                                        <th scope="col">Tanggal Pengambilan</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($surats as $row)
                                        <tr>
                                            <td>{{ $surats->firstItem() + $loop->index }}</td>
                                            <td>{{ $row->mahasiswa->name ?? 'N/A' }}</td>
                                            <td>{{ $row->kategori_surat }} </td>
                                            <td>{{ $row->content }} </td>
                                            <td>{{ $row->tanggal_pengambilan }}</td>
                                            <td>{{ $row->status }} </td>
                                            <td>
                                                <form action="{{ route('approve_surat', ['id' => $row->id]) }}"
                                                    method="post" class="d-inline">
                                                    @csrf
                                                    @method('put')
                                                    <button class="btn btn-success btn-sm" id="btn-approve"
                                                        onclick="return confirmAction('approve')">Approve</button>
                                                </form>
                                                <form action="{{ route('reject_surat', ['id' => $row->id]) }}"
                                                    method="post" class="d-inline">
                                                    @csrf
                                                    @method('put')
                                                    <button class="btn btn-danger btn-sm" id="btn-reject"
                                                        onclick="return confirmAction('reject')">Reject</button>
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
