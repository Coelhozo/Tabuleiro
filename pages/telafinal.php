<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/espera.css">
    <title>Document</title>
</head>
<body>
    <div class="logout">
        <form method="POST" action="../index.php">
            <input type="submit" value="sair" name="logout">
        </form>
    </div>
    <?php
        include '../php/dll.php';
    ?>
    <h1>O JOGO ACABOU !</h1>

    <?php
        $aluno_id = usarBanco("select aluno_id from histórico where partida =".$_SESSION['partida'][0], $retorno=True)[0]["aluno_id"];
        $ganhador = usarBanco("select nome from aluno where id = $aluno_id", $retorno=True)[0]["nome"];
    ?>

    <h2>O ganhador é: <?php echo $ganhador?></h2>
</body>
</html>