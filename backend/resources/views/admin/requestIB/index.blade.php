@extends('layouts.backend.main')
@section('title')
    Izin Bermalam
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
                                setTimeout(function() {
                                    $('.alert-success').fadeOut('slow');
                                }, 2400);
                            </script>
                        @elseif (session()->has('error'))
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>{{ session()->get('error') }}</strong>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            {{-- <script> --}}
                                setTimeout(function() {
                                    $('.alert-danger').fadeOut('slow');
                                }, 2400);
                            </script>
                        @endif
                        <div class="table-responsive">
                            <table id="cth" class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th scope="col">No</th>
                                        <th scope="col">Nama Mahasiswa</th>
                                        <th scope="col">Keterangan</th>
                                        <th scope="col">Tujuan</th>
                                        <th scope="col">Tanggal Berangkat</th>
                                        <th scope="col">Tanggal Kembali</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($izinBermalam as $row)
                                        <tr>
                                            <td>{{ $izinBermalam->firstItem() + $loop->index }}</td>
                                            {{-- Assuming that $row->mahasiswa_id is the foreign key linking to the Mahasiswa table --}}
                                            <td>{{ $row->mahasiswa->name ?? 'N/A' }}</td>
                                            <td>{{ $row->deskripsi }} </td>
                                            <td>{{$row->tujuan}}</td>
                                            <td>{{ $row->tanggal_berangkat }}</td>
                                            <td>{{ $row->tanggal_kembali }} </td>
                                            <td>{{ $row->status }} </td>
                                            <td>
                                                <form action="{{ route('approve_IzinBermalam', ['id' => $row->id]) }}"
                                                    method="post" class="d-inline">
                                                    @csrf
                                                    @method('put')
                                                    <button class="btn btn-success btn-sm" id="btn-approve"
                                                        onclick="return confirmAction('approve')">Approve</button>
                                                </form>
                                                <form action="{{ route('reject_IzinBermalam', ['id' => $row->id]) }}"
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
                                            <td colspan="8" class="text-center">{{ 'Data Masih Kosong' }}</td>
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
