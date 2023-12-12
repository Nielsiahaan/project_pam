<!doctype html>
<html lang="en">

<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="{{ asset('css/style.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/skins/all.css">

</head>

<body>
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-7 col-lg-5">
                    <div class="login-wrap p-4 p-md-5">
                        <div class="icon d-flex align-items-center justify-content-center mb-2">
                            <img src="{{ asset('logo.jpg') }}" class="img-fluid " alt="Logo" width="120">
                        </div>
                        <h2 class="text-center text-sm mb-4" style="font-size: 1em">Institut Teknologi Del</h2>
                        <hr style="border-top: 1px solid #eee; margin:2.6em 0 2em;">
                        <form action="{{ route('login') }}" class="login-form" method="POST">
                            @csrf
                            <div class="form-group">
                                <input id="email" type="email" :value="old('Email')" name="email"
                                    class="form-control rounded-left" placeholder="Email">
                                @error('email')
                                    <span class="text-danger mt-2">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group">
                                <input type="password" name="password"
                                    class="form-control rounded-left"
                                    placeholder="Password">
                                @error('password')
                                    <span class="text-danger mt-2">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="row align-items-center">
                                <div class="col-6">
                                    <div class="checkbox icheck">
                                        <label>
                                            <div class="form-group field-loginform-rememberme">
                                                <input type="hidden" name="LoginForm[rememberMe]" value="0">
                                                <label>
                                                    <input type="checkbox" id="loginform-rememberme"
                                                        name="LoginForm[rememberMe]" value="1">
                                                    Remember Me
                                                </label>
                                                <div class="help-block"></div>
                                            </div>

                                        </label>
                                    </div>
                                </div><!-- /.col -->
                                <div class="col-6 text-right" style="margin-top:-1.4em">
                                    <button style="border-radius: 2px" type="submit"
                                        class="btn btn-lock btn-primary btn-flat">Sign In</button>
                                </div><!-- /.col -->
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="{{ asset('js/jquery.min.js') }}"></script>
    <script src="{{ asset('js/popper.js') }}"></script>
    <script src="{{ asset('js/bootstrap.min.js') }}"></script>
    <script src="{{ asset('js/main.js') }}"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.2/icheck.min.js"></script>
    <script>
        $(document).ready(function() {
            // Enable iCheck plugin on the checkbox
            $('#loginform-rememberme').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                increaseArea: '20%'
            });

            // Get the checkbox element
            var rememberMe = document.getElementById("loginform-rememberme");

            // If the user has previously checked the "Remember Me" checkbox,
            // retrieve the saved email value and set it as the value of the email input
            if (localStorage.getItem("savedEmail") !== null && rememberMe.checked) {
                document.getElementById("email").value = localStorage.getItem("savedEmail");
            }

            // Listen for changes to the "Remember Me" checkbox
            $('#loginform-rememberme').on('ifChanged', function() {
                // If the user checks the "Remember Me" checkbox,
                // save the value of the email input to localStorage
                if (this.checked) {
                    localStorage.setItem("savedEmail", document.getElementById("email").value);
                }
                // If the user unchecks the "Remember Me" checkbox,
                // remove the saved email value from localStorage
                else {
                    localStorage.removeItem("savedEmail");
                }
            });
        });
    </script>

</body>

</html>
