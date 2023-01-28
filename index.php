<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/main.css?version=27">
    <meta http-equiv="refresh" content="15">
    <title>Document</title>
</head>
<body>
    <?php
        
        include './php/dll.php';
        extract($_POST);

        if (isset($logout)){
            logout();
        }

        if (isset($jogar)){
            if (!$_SESSION['esseJogador'] = validarLogin($nome, $senha)){
                header("Location: ./pages/telalogin.php");  
            }else {
                definirPartida();
            }
        }else if(!isset($_SESSION['esseJogador'])){
            header("Location: ./pages/telalogin.php");
        }

        definirPlayer();

        $pl = $_SESSION['player'];
        
        $pergunta = gerarPergunta($_SESSION['jogadores'][$pl], $pl);

        if (isset($b1) && verificarResposta($resposta_aluno, $per_id)){
            atualizarPontuacao($pergunta['id']);
        }

        $pontos = [];
        for ($c1 = 0; $c1 < 3; $c1++){
            $pont = usarBanco("select `pontuação` from jogo where aluno_id = ".$_SESSION['jogadores'][$c1]." and partida = ".$_SESSION['partida'], $retorno=True);
            array_push($pontos, $pont[0]['pontuação']);
        }

        foreach($pontos as $key => $value){
            if ($value >= 100){
                finalizarJogo($key);
            }
        }
        
        include('./pages/tabuleiro.php');
    ?>
    <base 
        thisPlayer = "<?php echo 'player-'.array_search($_SESSION['esseJogador'], $_SESSION['jogadores'])?>"
        player="<?php echo 'player-'.$_SESSION['player']?>"
        posicao-player-1="<?php if ($_SESSION['esseJogador'] == $_SESSION['jogadores'][0] || $pontos[0] != 0) echo $pontos[0]/10?>"
        posicao-player-2="<?php if ($_SESSION['esseJogador'] == $_SESSION['jogadores'][1] || $pontos[1] != 0) echo $pontos[1]/10?>"
        posicao-player-3="<?php if ($_SESSION['esseJogador'] == $_SESSION['jogadores'][2] || $pontos[2] != 0) echo $pontos[2]/10?>"
    >
    <?php //avancar="<?php if (isset($b1) && verificarResposta($resposta_aluno, $per_id)) echo $player?>
    <script src="./js/main.js?version=4"></script>
</body>
</html>