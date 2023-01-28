<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/login.css?version=3">
    <title>Login</title>
</head>

<body>
    <form method="POST" action="../index.php">
        <div>
            <h2>login</h2>
            <input type="text" placeholder="nome" name="nome" required>

            <h2>senha</h2>
            <input type="password" placeholder="senha" name="senha" required>
            
            <a href="telacadastro.php">Não tem conta?</a>

            <input type="submit" name="jogar" value="jogar">

        </div>
    </form>
</body>

</html>