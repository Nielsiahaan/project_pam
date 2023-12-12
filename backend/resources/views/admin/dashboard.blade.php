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
                                <p>{{ __('Pengumuman') }}</p>
                            </div>
                            <div class="icon">
                                <i class="nav-icon fas fa-bell"></i>
                            </div>
                            {{-- <a href="{{ route('pengumuman.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-warning">
                            <div class="inner">
                                {{-- <h3>{{ $artikel }}</h3> --}}
                                <p>{{ __('Artikel') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            {{-- <a href="{{ route('artikel.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-info">
                            <div class="inner">
                                {{-- <h3>{{ $event }}</h3> --}}
                                <p>{{ __('Event') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            {{-- <a href="{{ route('event.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-danger">
                            <div class="inner">
                                {{-- <h3>{{ $berita }}</h3> --}}
                                <p>{{ __('Berita') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-globe"></i>
                            </div>
                            {{-- <a href="{{ route('berita.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-maroon">
                            <div class="inner">
                                {{-- <h3>{{ $pelapor }}</h3> --}}
                                {{-- <p>{{ __('Pelapor') }}</p> --}}
                            </div>
                            <div class="icon">
                                <i class="fas fa-users"></i>
                            </div>
                            {{-- <a href="{{ route('laporan.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-dark gray">
                            <div class="inner">
                                {{-- <h3>{{ $kategoriPelapor }}</h3> --}}
                                <p>{{ __('Kategori Pelapor') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-tag"></i>
                            </div>
                            {{-- <a href="{{ route('kategoriPelapor.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-lightblue">
                            <div class="inner">
                                {{-- <h3>{{ $profil }}</h3> --}}
                                <p>{{ __('Profil') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            {{-- <a href="{{ route('meta.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-pink">
                            <div class="inner">
                                {{-- <h3>{{ $faqs }}</h3> --}}
                                <p>{{ __('FAQ') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-question-circle"></i>
                            </div>
                            {{-- <a href="{{ route('faq.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-lime">
                            <div class="inner">
                                {{-- <h3>{{ $galery }}</h3> --}}
                                <p>{{ __('Galery') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-images"></i>
                            </div>
                            {{-- <a href="{{ route('galery.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-secondary">
                            <div class="inner">
                                {{-- <h3>{{ $kategori }}</h3> --}}
                                <p>{{ __('Kategori') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-tag"></i>
                            </div>
                            {{-- <a href="{{ route('kategori.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-primary">
                            <div class="inner">
                                {{-- <h3>{{ $file }}</h3> --}}
                                <p>{{ __('File') }}</p>
                            </div>
                            <div class="icon">
                                <i class="fas fa-file"></i>
                            </div>
                            {{-- <a href="{{ route('file.index') }}" class="small-box-footer">More info <i
                                    class="fas fa-arrow-circle-right"></i></a> --}}
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </section>
@endsection
