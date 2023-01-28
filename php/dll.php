<?php
    session_start();
    date_default_timezone_set("America/Bahia");

    function usarBanco($consulta, $retorno=False, $multi=False){
        include 'db_vars.php';

        mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
        $banco = new mysqli($host, $user, $pass, $bd);
        
        if ($multi){
            $banco->multi_query($consulta);
            if ($retorno){
                $dados =[];
                do{
                    if($result = $banco->store_result()){
                        while($linha = $result->fetch_row()){
                            array_push($dados, $linha[0]);
                        }
                    }
                }while($banco->next_result());
                return $dados;
            }
            
        }

        if(!$result=$banco->query($consulta)){
            print_r($result);
            $banco->error;
        }

        if($retorno){
            $dados = [];
            while ($linha = $result -> fetch_assoc()){
                array_push($dados, $linha);
            }
            return $dados;
        }
    }

    function definirPlayer(){

        if(!isset($_SESSION['player']) || $_SESSION['player'] >= 2){

            if (!isset($_SESSION['jogadores'])){
                
                $jogadores = usarBanco("select aluno_id from jogo where partida = ".$_SESSION['partida'].";", $retorno = True);
                
                $_SESSION['jogadores'] = [];
                foreach ($jogadores as $key => $value) {
                    array_push($_SESSION['jogadores'], $value['aluno_id']);
                }

                if (count($_SESSION['jogadores']) < 3){
                    header("Location: ./pages/telaespera.php");
                }
            }
            
            $_SESSION['player'] = 0;
            
        }else{
            $_SESSION['player']++;
        }
    }

    function gerarPergunta($esseJogador, $pl){

        if ($esseJogador == $_SESSION['jogadores'][$pl]){
            $pergunta_id = usarBanco(
                "SET @ultimo = (SELECT max(id) from pergunta_sorteada);
    
                SET @perg = (select id
                FROM pergunta 
                WHERE 
                    id not in (
                        select pergunta_id from pergunta_sorteada where id >= @ultimo-3
                    )
                ORDER BY rand() limit 1);
                
                INSERT INTO pergunta_sorteada (pergunta_id, aluno_id, partida) VALUES(@perg, $esseJogador, ".$_SESSION['partida'].");
                
                SELECT @perg;", 
            $retorno=True, $multi=True);

            $pergunta = usarBanco("SELECT * FROM pergunta WHERE id = $pergunta_id[0]", $retorno=True)[0];
            return $pergunta;
        }

        $pergunta_id = usarBanco("
            select id from pergunta_sorteada where id = (select max(id) from pergunta_sorteada);
        ", $retorno=True, $multi=True);
        $pergunta = usarBanco("SELECT * FROM pergunta WHERE id = $pergunta_id[0]", $retorno=True)[0];
        return $pergunta;
    }

    function verificarResposta($resp, $per_id){
        $resp_certa = usarBanco("
            SELECT resposta1, resposta2, resposta3, resposta4, correta FROM pergunta WHERE id=$per_id", 
            $retorno=True
        )[0];
        $pl = $_SESSION['player'];
        //if ($_SESSION['jogadores'][$pl] == usarBanco("select aluno_id from pergunta_sorteada where id = (select max(id) from pergunta_sorteada);", $retorno=True)[0]["aluno_id"]) return False;
        if ($_SESSION['jogadores'][$pl] != usarBanco("select aluno_id from pergunta_sorteada where id = (select max(id) from pergunta_sorteada);", $retorno = True)[0]['aluno_id']) return False;
        if ($resp == $resp_certa["resposta".$resp_certa["correta"]]){  
            return True;
        }else {
            return False;
        } 
    }

    /*
    function gerarPosicao($player){
        for ($c=0; $c < 3; $c++) { 
            if(isset($_SESSION['posicao-player-'.$c]) && $_SESSION['posicao-player-'.$c] >= 10){
                unset($_SESSION['posicao-player-'.$c]);
            }
        }
        
        if (isset($_SESSION['posicao-'.$player])){
            $_SESSION['posicao-'.$player]++;
        }else{
            $_SESSION['posicao-'.$player] = 1;
        }
    }
    */

    function validarLogin($nome, $senha){
        $result = usarBanco("SELECT id FROM aluno WHERE senha = '$senha' and nome = '$nome' LIMIT 1;", 
        $retorno=True);
    
        if (!empty($result)){
            usarBanco("UPDATE aluno SET logado = True WHERE id = ".$result[0]['id']);
            return $result[0]['id'];
        }
        return False;
    }

    function definirPartida(){

        $inicio = date("Y-m-d")." ".date("H:i:s");
        if (empty($partida = usarBanco(
                "select partida from jogo where aluno_id = ".$_SESSION["esseJogador"]." limit 1;",
                $retorno = True
        ))){
            
            if(empty($partida = usarBanco(
                "select partida from partidas where `número de jogadores` < 3 ORDER BY `número de jogadores` DESC limit 1",
                $retorno = True
            ))){
                
                if (empty(usarBanco("select partida from histórico", $retorno=True)[0])) {
                    echo "1";
                    $partida = usarBanco(
                        "
                        insert into jogo (inicio, fim, aluno_id)
                        values
                            ('$inicio', null, ".$_SESSION['esseJogador'].");
                        
                        select partida from jogo where id = (select max(id) from jogo);
                        ", $multi = True, $retorno = True
                    );
                    $_SESSION['partida'] = $partida[0];
                    return;
                }else{
                    if (empty(usarBanco("select max(partida) as 'partida' from jogo", $retorno=True))){
                        $partida = usarBanco(
                            "
                            set @partida = (select max(partida) from histórico);
                
                            insert into jogo (partida, inicio, fim, aluno_id)
                            values
                                (@partida+1, '$inicio', null, ".$_SESSION['esseJogador'].");
                                
                            select partida from jogo where id = (select max(id) from jogo);
                            ", $retorno=True, $multi=True
                        );
                    }else{
                        $partida = usarBanco("
                            set @partida = (select max(partida) as 'partida' from jogo);

                            insert into jogo (partida, inicio, fim, aluno_id)
                            values
                                (@partida+1, '$inicio', null, ".$_SESSION['esseJogador'].");
                            select @partida+1 as 'partida'
                        ", $retorno=True, $multi=True);
                        $_SESSION['partida'] = $partida[0];
                        return;
                    }
                }
            }else{
                usarBanco("
                    insert into jogo (partida, inicio, fim, aluno_id)
                    values
                        (".$partida[0]['partida'].", '$inicio', null, ".$_SESSION['esseJogador'].");
                ");
            }
        }
        
        $_SESSION['partida'] = $partida[0]['partida'];
    }

    function logout(){
        $sessoes = [
            "jogadores",
            "player",
            "esseJogador",
            "partida",
            "posicao-player-0",
            "posicao-player-1",
            "posicao-player-2"
        ];
        
        foreach ($sessoes as $key => $value) {
            unset($_SESSION[$value]);
        }
    }

    function atualizarPontuacao ($pergunta_id){
        $pl = $_SESSION['player'];
        if (
            $_SESSION['esseJogador'] == $_SESSION['jogadores'][$pl] &&
            $pergunta_id == usarBanco("select pergunta_id from pergunta_sorteada where id = (select max(id) from pergunta_sorteada);", $retorno=True)
        ) return;
        usarBanco("
            set @pont = (select pontuação from jogo where partida = ".$_SESSION['partida']." and aluno_id = ".$_SESSION['esseJogador'].");
            
            update jogo set pontuação = @pont+10 where partida = ".$_SESSION['partida']." and aluno_id = ".$_SESSION['esseJogador']."
        ", $multi = True, $retorno = True);
    }

    function finalizarJogo($id){
        usarBanco("insert into histórico (partida, aluno_id) values (".$_SESSION['partida'].", ".$_SESSION['jogadores'][$id].")");
        usarBanco("delete from jogo where partida = ".$_SESSION['partida']);
        usarBanco("delete from pergunta_sorteada where partida = ".$_SESSION['partida']);

        header("Location: ./pages/telafinal.php");
    }
?>
