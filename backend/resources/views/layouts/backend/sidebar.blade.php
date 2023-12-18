<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="http://www.del.ac.id" class="brand-link">
        <img src="{{ asset('backend/dist/img/icon.jpeg') }}" alt="AdminLTE Logo" class="brand-image elevation-3"
            style="opacity: .8">
        <span class="brand-text font-weight-light">CIS IT DEL</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="{{ asset('backend/dist/img/avatar5.png') }}" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <a href="#" class="d-block">{{ Auth::user()->name }}</a>
            </div>
        </div>
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search"
                    aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                data-accordion="false">
                <li class="nav-item">
                    <a href="{{ route('dashboard') }}" class="nav-link" data-breadcrumb="Dashboard">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            {{ __('Dashboard') }}
                        </p>
                    </a>

                </li>
                <li class="nav-item">
                    <a href="{{ route('room.index') }}" class="nav-link" data-breadcrumb="Room">
                        <i class="nav-icon fas fa-bell"></i>
                        <p>
                            {{ __('Room') }}
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="{{ route('requestIk.index') }}" class="nav-link" data-breadcrumb="Request IK">
                        <i class="nav-icon fas fa-file-alt"></i>
                        <p>{{ __('Izin Keluar') }} </p>
                    </a>

                </li>
                <li class="nav-item">
                    <a href="{{route('requestIB.index')}}" class="nav-link" data-breadcrumb="Berita">
                        <i class="nav-icon fas fa-globe"></i>
                        <p>{{ __('Izin Bermalam') }}</p>
                    </a>

                </li>
                <li class="nav-item">
                    <a href="{{ route('requestSurat.index') }}" class="nav-link" data-breadcrumb="Event">
                        <i class="nav-icon fas fa-clock"></i>
                        <p>{{ __('Request Surat') }}</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-breadcrumb="Berita">
                        <i class="nav-icon fas fa-globe"></i>
                        <p>{{ __('Booking Room') }}</p>
                    </a>

                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
@push('js')
@endpush
