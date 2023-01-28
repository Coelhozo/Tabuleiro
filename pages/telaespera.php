<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="refresh" content="3" >
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
        /*
        unset($_SESSION['player']);
        unset($_SESSION['jogadores']);
        */
        $nJogadores = usarBanco("select `número de jogadores` from partidas where partida = ".$_SESSION['partida'], $retorno=True)[0]["número de jogadores"];
        echo "<p>Número de jogadores na sala: ".$nJogadores."/3</p>";
        if ($nJogadores >= 3){
            header("Location: ../index.php");
        }
    ?>
    <h1>espere aqui até acharmos uma partida</h1>
</body>
</html>