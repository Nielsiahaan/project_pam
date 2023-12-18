@extends('layouts.backend.main')
@section('title')
    Dashboard
@endsection
@section('content')
    <section class="content">
        <div class="card">
            <div class="card-header">
                <h4 style="color: rgb(0, 166, 255);" class="card-title">MENU ADMIN</h4>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-teal">
                            <div class="inner">
                                {{-- <h3>{{ $pengumuman }}</h3> --}}
                                <p>{{ __('Room') }}</p>
                            </div>
                            <div class="icon">
                                <i class="nav-icon fas fa-bell"></i>
                            </div>
                            <a href="{{ route('room.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-warning">
                            <div class="inner">
                                {{-- <h3>{{ $artikel }}</h3> --}}
                                <p>{{ __('Izin Keluar') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            <a href="{{ route('requestIk.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-info">
                            <div class="inner">
                                {{-- <h3>{{ $event }}</h3> --}}
                                <p>{{ __('Request Surat') }}</p>
                            </div>
                            {{-- <div class="icon"> --}}
                                <i class="fas fa-clock"></i>
                            </div>
                            <a href="{{ route('requestSurat.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-danger">
                            <div class="inner">
                                {{-- <h3>{{ $berita }}</h3> --}}
                                <p>{{ __('Izin Bermalam') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-globe"></i>
                            </div>
                            <a href="{{ route('requestIB.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </section>
@endsection
