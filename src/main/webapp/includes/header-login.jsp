
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>header login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sign-in/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }


        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }


        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
        body {
            height: 100%;
        }


            .form-signin {
            max-width: 330px;
            padding: 1rem;
        }

        .form-signin .form-floating:focus-within {
            z-index: 2;
        }

        .form-signin input[type="email"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
        .bg-image {
            background-image: url("https://i.pinimg.com/originals/b6/e6/0c/b6e60c232eea473eb8bce612ed569cd3.gif");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
        .bg-image2 {
            background-image: url("https://wallpaperaccess.com/full/5599491.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
    </style>
</head>

<body class="bg-image">
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax("login", {
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        if (response === "ok") {
                            window.location.href = "/retrocomputer";
                        } else {
                            $("#result").html(response);
                        }
                    }
                }
            });
        });
    });
</script>

<header data-bs-theme="dark">
    <div class="collapse text-bg-dark" id="navbarHeader">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-md-7 py-4">
                    <h4>Sobre Nosostros</h4>
                    <p class="text-body-secondary">Somos unos apasionados del mundo de la microinformática y de la informática de los años 80 y 90, para conocernos mas contacta con nosotros</p>
                </div>
                <div class="col-sm-4 offset-md-1 py-4">
                    <h4>Contacto</h4>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Siguenos en X</a></li>
                        <li><a href="#" class="text-white">también en Facebook</a></li>
                        <li><a href="mailto:retrobyte@retrobyte.com" class="text-white">retobyte@retrobyte.com</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a href="/retrocomputer" class="navbar-brand d-flex align-items-center">
                <svg width="3cm" height="2cm" viewBox="0 0 200 120"
                     xmlns="http://www.w3.org/2000/svg" version="1.1">
                    <title>logo</title>
                    <defs>
                        <filter id="MyFilter" filterUnits="userSpaceOnUse" x="0" y="0" width="200" height="120">
                            <feGaussianBlur in="SourceAlpha" stdDeviation="4" result="blur"/>
                            <feOffset in="blur" dx="4" dy="4" result="offsetBlur"/>
                            <feSpecularLighting in="blur" surfaceScale="5" specularConstant=".75"
                                                specularExponent="20" lighting-color="#bbbbbb"
                                                result="specOut">
                                <fePointLight x="-5000" y="-10000" z="20000"/>
                            </feSpecularLighting>
                            <feComposite in="specOut" in2="SourceAlpha" operator="in" result="specOut"/>
                            <feComposite in="SourceGraphic" in2="specOut" operator="arithmetic"
                                         k1="0" k2="1" k3="1" k4="0" result="litPaint"/>
                            <feMerge>
                                <feMergeNode in="offsetBlur"/>
                                <feMergeNode in="litPaint"/>
                            </feMerge>
                        </filter>
                    </defs>
                    <rect x="1" y="1" width="198" height="118" fill="#888888" stroke="blue" />
                    <g filter="url(#MyFilter)" >
                        <g>
                            <path fill="none" stroke="#D90000" stroke-width="10"
                                  d="M50,90 C0,90 0,30 50,30 L150,30 C200,30 200,90 150,90 z" />
                            <path fill="#D90000"
                                  d="M60,80 C30,80 30,40 60,40 L140,40 C170,40 170,80 140,80 z" />
                            <g fill="#FFFFFF" stroke="black" font-size="35" font-family="Verdana" >
                                <text x="72" y="71"> ;-) </text>
                            </g>
                        </g>
                    </g>
                </svg>
                <h2 style="color:red;"><strong>&nbsp;RetroByte</strong></h2>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</header>

