<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
    </ul>


    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        {{-- <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="far fa-bell"></i>
                <span class="badge badge-danger navbar-badge">{{ auth()->user()->unreadNotifications->count() }}</span>
            </a>
            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="min-width: 270px">
                <span class="dropdown-item dropdown-header">{{ auth()->user()->unreadNotifications->count() }}
                    Notification</span>
                @foreach (auth()->user()->unreadNotifications as $notification)
                    @if ($notification->type === 'App\Notifications\laporanNotification')
                        <div class="dropdown-divider"></div>
                        <a href="{{ route('laporan.index') }}" class="dropdown-item">
                            <p class="text-sm">
                                <i class="fas fa-envelope mr-2"></i>
                                <span>{{ $notification->data['nama_pelapor'] }} has reported</span>
                                <span class="float-end text-muted text-sm" style="word-wrap: break-word;float: right;">
                                    @if ($notification->created_at->diffInSeconds() < 60)
                                        {{ $notification->created_at->diffInSeconds() }} sec
                                    @elseif ($notification->created_at->diffInMinutes() < 60)
                                        {{ $notification->created_at->diffInMinutes() }} min
                                    @elseif ($notification->created_at->diffInHours() < 24)
                                        {{ $notification->created_at->diffInHours() }} hour
                                    @else
                                        {{ $notification->created_at->diffInDays() }} day
                                    @endif
                                </span>
                            </p>
                        </a>
                        <div class="float-right px-2 justify-content-between align-items-center">
                            <a href="{{ route('notif', $notification->id) }}" class="text-muted text-sm">Mark as
                                read</a>
                        </div>
                    @endif
                    @if ($notification->type === 'App\Notifications\FaqNotification')
                        <div class="dropdown-divider"></div>
                        <a href="{{ route('laporan.index') }}" class="dropdown-item">
                            <p class="text-sm">
                                <i class="fas fa-envelope mr-2"></i>
                                <span>{{ $notification->data['nama'] }} has asked </span>
                                <span class="float-end text-muted text-sm" style="word-wrap: break-word;float: right;">
                                    @if ($notification->created_at->diffInSeconds() < 60)
                                        {{ $notification->created_at->diffInSeconds() }} sec
                                    @elseif ($notification->created_at->diffInMinutes() < 60)
                                        {{ $notification->created_at->diffInMinutes() }} min
                                    @elseif ($notification->created_at->diffInHours() < 24)
                                        {{ $notification->created_at->diffInHours() }} hour
                                    @else
                                        {{ $notification->created_at->diffInDays() }} day
                                    @endif
                                </span>
                            </p>
                        </a>
                        <div class="float-right px-2 justify-content-between align-items-center">
                            <a href="{{ route('notif', $notification->id) }}" class="text-muted text-sm">Mark as
                                read</a>
                        </div>
                    @endif
                @endforeach
            </div>
        </li> --}}


        <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="fas fa-user"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right user-panel">
                <span class="dropdown-item dropdown-header">{{ Auth::user()->name }}</span>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                    <i class="fas fa-user mr-2"></i> Profile
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                    <i class="fas fa-key mr-2"></i>Change Password
                </a>
                <div class="dropdown-divider"></div>
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <a class="dropdown-item" href="{{ route('logout') }}"
                        onclick="event.preventDefault();
                                    this.closest('form').submit();">
                        <i class="fas fa-sign-out-alt mr-2"></i>
                        {{ __('Log Out') }}</a>
                </form>
            </div>
        </li>
    </ul>

</nav>
<!-- /.navbar -->
