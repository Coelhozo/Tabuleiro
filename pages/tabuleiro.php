<header>
    <div class="logout">
        <form method="POST" action="index.php">
            <input type="submit" value="sair" name="logout">
        </form>
    </div>
    <h1>a corrida animal</h1>
    <div>
        <p>pontuação</p>
        <div>
            <span><?php echo usarBanco("select nome from aluno where id = ".$_SESSION['jogadores'][0], $retorno=True)[0]['nome']?>: <i><?php echo $pontos[0];?> pt</i></span>
            <span><?php echo usarBanco("select nome from aluno where id = ".$_SESSION['jogadores'][1], $retorno=True)[0]['nome']?>: <i><?php echo $pontos[1];?> pt</i></span>
            <span><?php echo usarBanco("select nome from aluno where id = ".$_SESSION['jogadores'][2], $retorno=True)[0]['nome']?>: <i><?php echo $pontos[2];?> pt</i></span>
        </div>
    </div>
</header>
<button onclick="mostrarPergunta()" class="perg">pergunta</button>
<main>
    <div class="counter">
        <span id="counter">sua vez!</span>
    </div>
    <div id="modal" class="modal">
        <div>Boa Sorte 
            <?php 
                $index = $_SESSION['player'];
                echo usarBanco("SELECT nome FROM aluno WHERE id = ".$_SESSION['jogadores'][$index], $retorno=True)[0]['nome'];
            ?>!
            <div class="timer">
                
            </div>
        </div>
        <button onclick="mostrarPergunta()">tabuleiro</button>
        <form method="POST" action="index.php">
            <div class="content">
                <p><?php echo $pergunta['questao']?>?</p>
                <div>
                    <input type="radio" name="resposta_aluno" value="<?php echo $pergunta['resposta1']?>"><span><?php echo $pergunta['resposta1']?></span>
                </div>
                <div>
                    <input type="radio" name="resposta_aluno" value="<?php echo $pergunta['resposta2']?>"><span><?php echo $pergunta['resposta2']?></span>
                </div>
                <div>
                    <input type="radio" name="resposta_aluno" value="<?php echo $pergunta['resposta3']?>"><span><?php echo $pergunta['resposta3']?></span>
                </div>
                <div>
                    <input type="radio" name="resposta_aluno" value="<?php echo $pergunta['resposta4']?>"><span><?php echo $pergunta['resposta4']?></span>
                </div>
            </div>
            <input type="hidden" name="per_id" value="<?php echo $pergunta['id']?>">
            <input type="hidden" name="player" value="<?php echo "player-".$_SESSION['player'];?>">
            <?php if ($_SESSION['esseJogador'] == $_SESSION['jogadores'][$pl]) {
                echo '<input type="submit" value="enviar" name="b1">';
            }?>
        </form>
    </div>
    <!--<span></span>-->
    <section id="player-1"><div><span></span></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div></section>
    
    <section id="player-2"><div><span></span></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div></section>

    <section id="player-3"><div><span></span></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div> <div></div></section>
</main>
