<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title')</title>
    <!-- Favicon -->
    <link href="{{ asset('frontend/img/icon.jpeg') }}" rel="icon">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="{{ asset('backend/plugins/fontawesome-free/css/all.min.css') }}">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet"
        href="{{ asset('backend/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/icheck-bootstrap/icheck-bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/jqvmap/jqvmap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/dist/css/adminlte.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/overlayScrollbars/css/OverlayScrollbars.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/daterangepicker/daterangepicker.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/summernote/summernote-bs4.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/plugins/sweetalert2/sweetalert2.min.css') }}">
    <link rel="stylesheet" href="{{ asset('backend/dist/css/darkmode.css') }}">
    {{-- Font awesome --}}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    @stack('css')
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
        {{-- Navbar --}}
        @include('layouts.backend.navbar')

        {{-- Sidebar --}}
        @include('layouts.backend.sidebar')
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-left" id="breadcrumb-container">
                                <li class="breadcrumb-item">
                                    <a href="{{ route('dashboard') }}">
                                        <i class="fa fa-home"></i> {{ __('Home') }}
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" id="active-breadcrumb"></li>
                            </ol>
                        </div>
                        <div class="col-sm-6">
                            <div class="float-sm-right">
                                <div class="btn-group">
                                    <a type="submit" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <i class="fa fa-gear mr-2"></i>{{ __('Account Settings') }}
                                    </a>
                                    <div class="dropdown-menu">
                                        <a href="#" class="dropdown-item"><i
                                                class="fa fa-user mr-2"></i>{{ __('Update Profile') }}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.row -->
                </div><!-- /.container-fluid -->
            </div>

            <!-- /.content-header -->

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    @yield('content')
                </div>
            </section>
            <!-- /.content -->
        </div>

        <div class="theme-panel">
            <a href="javascript:;" data-click="theme-panel-expand" class="theme-collapse-btn">
                <i class="fa fa-cog"></i>
            </a>
            <div class="theme-panel-content">
                <div class="row py-3px">
                    <div class="col-9 control-label text-dark fw-bold">
                        <div class="text-dark">{{ __('Dark Mode') }}</div>
                    </div>
                    <div class="col-3 d-flex">
                        <div class="form-check form-switch ms-auto mb-0 mt-2px">
                            <input type="checkbox" class="form-check-input theme-checkbox" name="app-theme-dark-mode"
                                id="appThemeDarkMode" value="1">
                            <label class="form-check-label" for="appThemeDarkMode">&nbsp;</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.content-wrapper -->

        {{-- Footer --}}
        @include('layouts.backend.footer')

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Control sidebar content goes here -->
        </aside>
        <!-- /.control-sidebar -->
    </div>
    <!-- ./wrapper -->

    <!-- jQuery -->

    <script src="{{ asset('backend/plugins/jquery/jquery.min.js') }}"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="{{ asset('backend/plugins/jquery-ui/jquery-ui.min.js') }}"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"></script>
    <script src="{{ asset('backend/plugins/sweetalert2/sweetalert2.all.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/sweetalert2/sweetalert2.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/chart.js/Chart.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/sparklines/sparkline.js') }}"></script>
    <script src="{{ asset('backend/plugins/jqvmap/jquery.vmap.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/jqvmap/maps/jquery.vmap.usa.js') }}"></script>
    <script src="{{ asset('backend/plugins/jquery-knob/jquery.knob.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/moment/moment.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/daterangepicker/daterangepicker.js') }}"></script>
    <script src="{{ asset('backend/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/summernote/summernote-bs4.min.js') }}"></script>
    <script src="{{ asset('backend/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js') }}"></script>
    <script src="{{ asset('backend/dist/js/adminlte.js') }}"></script>
    <script src="{{ asset('backend/dist/js/pages/dashboard.js') }}"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- AdminLTE App -->
    <script src="../../dist/js/adminlte.min.js"></script>
    @stack('js')
</body>
<script>
    $(document).ready(function() {
        // Mendapatkan elemen checkbox Dark Mode
        var darkModeCheckbox = $('#appThemeDarkMode');

        // Mendapatkan elemen body
        var body = $('body');

        // Cek status Dark Mode saat halaman dimuat
        var darkModeStatus = localStorage.getItem('darkModeStatus');

        // Memperbarui tampilan berdasarkan status Dark Mode
        if (darkModeStatus === 'true') {
            enableDarkMode();
            darkModeCheckbox.prop('checked', true);
        } else {
            disableDarkMode();
            darkModeCheckbox.prop('checked', false);
        }

        // Mengatur perilaku klik pada checkbox Dark Mode
        darkModeCheckbox.click(function() {
            if ($(this).is(':checked')) {
                enableDarkMode();
                localStorage.setItem('darkModeStatus', 'true');
            } else {
                disableDarkMode();
                localStorage.setItem('darkModeStatus', 'false');
            }
        });

        // Fungsi untuk mengaktifkan Dark Mode
        function enableDarkMode() {
            body.addClass('dark-mode');
        }

        // Fungsi untuk menonaktifkan Dark Mode
        function disableDarkMode() {
            body.removeClass('dark-mode');
        }
    });
    $(document).ready(function() {
        $('.theme-panel').removeClass('active'); // Remove 'active' class initially

        $('.theme-collapse-btn').click(function() {
            $('.theme-panel').toggleClass('active');
        });
    });
    $(document).ready(function() {
        // Menampilkan data breadcrumb saat halaman dimuat
        var activeBreadcrumb = $('.breadcrumb-item.active').text();
        $('#active-breadcrumb').text(activeBreadcrumb);

        // Mengatur perilaku klik menu sidebar
        $('.nav-link').click(function() {
            // Mengambil nilai breadcrumb dari atribut data-breadcrumb
            var breadcrumb = $(this).data('breadcrumb');

            // Menampilkan nilai breadcrumb pada elemen dengan id active-breadcrumb
            $('#active-breadcrumb').text(breadcrumb);
        });
    });


    $(document).on('click', '#btn-hapus', function(e) {
        e.preventDefault();

        Swal.fire({
            title: 'Apakah anda yakin?',
            text: "Data akan dihapus!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, hapus!'
        }).then((result) => {
            if (result.isConfirmed) {
                $('form').submit();
                Swal.fire(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                )
            }
        })
    });

    $(document).ready(function() {
        $('#btn-simpan').click(function(e) {
            e.preventDefault(); // menghentikan form submit

            if (!$('#kategori').val()) {
                Swal.fire(
                    'Maaf!',
                    'Data masih kosong.',
                    'warning'
                );
                return false;
            }

            // menampilkan SweetAlert2
            Swal.fire({
                title: 'Apakah anda yakin?',
                text: "Data akan disimpan!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, simpan!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // jika tombol "Yes, simpan!" ditekan, submit form
                    $('form').submit();

                    Swal.fire(
                        'Tersimpan!',
                        'Datamu berhasil.',
                        'success'
                    )

                }
            })
        });
    });
    // alert untuk update berita dan artikel
    $(document).ready(function() {
        $('#btn-update').click(function(e) {
            e.preventDefault(); // menghentikan form submit
            if (!$('#judul' && '#description' && '#kategori' && '#status').val()) {
                Swal.fire(
                    'Maaf!',
                    'Data masih kosong.',
                    'warning'
                );
                return false;
            }
            // menampilkan SweetAlert2
            Swal.fire({
                title: 'Apakah anda yakin?',
                text: "Data akan disimpan!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, simpan!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // jika tombol "Yes, simpan!" ditekan, submit form
                    $('form').submit();

                    Swal.fire(
                        'Tersimpan!',
                        'Datamu berhasil.',
                        'success'
                    )

                }
            })
        });
    });
    $(document).on('click', '#btn-batal', function(e) {
        e.preventDefault();

        Swal.fire({
            title: 'Apakah anda yakin?',
            text: "Data yang belum disimpan akan hilang!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, batal!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = $(this).attr('href');
            }
        })
    });

    ClassicEditor
        .create(document.querySelector('#description'))
        .catch(error => {
            console.error(error);
        });

    // Get the input element and button for sidebar search
    const searchInput = document.getElementById('sidebar-search-input');
    const searchButton = document.getElementById('sidebar-search-button');

    // Add a click event listener to the search button
    searchButton.addEventListener('click', function() {
        const searchTerm = searchInput.value.toLowerCase();
        const navLinks = document.querySelectorAll('.nav-sidebar .nav-link');

        // Loop through each nav link and check if the search term is found in the link's text
        for (let i = 0; i < navLinks.length; i++) {
            const navLink = navLinks[i];
            const linkText = navLink.innerText.toLowerCase();

            if (linkText.includes(searchTerm)) {
                navLink.style.display = 'block'; // Show the matching nav link
            } else {
                navLink.style.display = 'none'; // Hide the non-matching nav link
            }
        }
    });
</script>


</html>
