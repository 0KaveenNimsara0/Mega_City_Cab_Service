<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f7c427;
            --bg: #ffffff;
            --card-bg: #f5f5f5;
            --text-primary: #333333;
            --text-secondary: #666666;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .container {
            text-align: center;
            padding: 50px 20px;
        }

        .logo-icon {
            margin-right: 10px;
            font-size: 48px;
            color: var(--primary);
        }

        .title {
            font-weight: 700;
            font-size: 36px;
            color: var(--text-primary);
            margin-bottom: 30px;
        }

        .btn-custom {
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s;
            margin: 10px;
            border: none;
        }

        .btn-register {
            background-color: var(--primary);
            color: #000;
        }

        .btn-register:hover {
            background-color: #e3b324;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(247, 196, 39, 0.3);
        }

        .btn-login {
            background-color: transparent;
            color: var(--text-primary);
            border: 2px solid var(--primary);
        }

        .btn-login:hover {
            background-color: var(--primary);
            color: #000;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(247, 196, 39, 0.3);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="mb-4">
        <i class="fas fa-taxi logo-icon"></i>
        <h1 class="title">Mega City Cab Service</h1>
    </div>
    <div>
        <a href="Register.jsp" class="btn btn-custom btn-register">
            <i class="fas fa-user-plus"></i> Register
        </a>
        <a href="Login.jsp" class="btn btn-custom btn-login">
            <i class="fas fa-sign-in-alt"></i> Login
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>