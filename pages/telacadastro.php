<?php
    include '../php/dll.php';
    extract($_POST);
    if (isset($cadastro)){
        if (usarBanco("SELECT id FROM aluno WHERE nome = '$nome';") != Array ()){
            echo "<h2>Esse usuário já existe</h2>";
        }else{
            usarBanco(
                "INSERT INTO aluno (nome, senha, turma_id)
                VALUES
                    ('$nome', '$senha', $turma);"
            );
        }
    }

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/login.css">
    <link rel="stylesheet" href="../css/cadastro.css?version=1">
    <title>cadastro</title>
</head>

<body>
    <form method="POST" action="telaCadastro.php">
        
        <div>
            <h2>Cadastro</h2>
            <input type="text" placeholder="nome" name="nome" required>
            
            <h2>Senha</h2>
            <input type="password" placeholder="senha" name="senha" required>
            
            <select name="turma" required>
                <option selected disabled>Escolha a turma</option>
                <?php
                    $turmas = usarBanco("select nome, id, ano_letivo from turma", $retorno=True);
                    foreach ($turmas as $key => $value){
                        echo "
                            <option value='".$value["id"]."'>".$value["nome"]." ".$value["ano_letivo"]."</option>
                        ";
                    }
                ?>
            </select>

            <input type="submit" name="cadastro" value="cadastro">
            
            <a href="telalogin.php">voltar</a>
        </div>
    </form>
</body>

</html>