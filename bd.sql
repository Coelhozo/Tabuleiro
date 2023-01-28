-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Jan-2023 às 20:55
-- Versão do servidor: 10.4.17-MariaDB
-- versão do PHP: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bd`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPergunta` (IN `player` INT, IN `partida` INT)  BEGIN
	SET @ultimo = (SELECT max(id) from pergunta_sorteada);

	SET @perg = (select id
	FROM pergunta 
	WHERE 
		id not in (
			select pergunta_id from pergunta_sorteada where id >= @ultimo-4
		)
		ORDER BY rand() limit 1);
            
	INSERT INTO pergunta_sorteada (pergunta_id, aluno_id, partida) VALUES(@perg, player, partida);
            
	SELECT @perg;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aluno`
--

CREATE TABLE `aluno` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `logado` tinyint(4) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'ativo',
  `senha` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aluno`
--

INSERT INTO `aluno` (`id`, `nome`, `turma_id`, `logado`, `status`, `senha`) VALUES
(27, 'pedro', 2, 1, 'ativo', '123'),
(28, 'lucas', 2, 1, 'ativo', '123'),
(29, 'jao', 2, 1, 'ativo', '123'),
(30, 'pedro', 2, 1, 'ativo', 'pedro'),
(31, 'pedro2', 2, 1, 'ativo', 'pedro2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `assunto`
--

CREATE TABLE `assunto` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `assunto`
--

INSERT INTO `assunto` (`id`, `nome`) VALUES
(6, 'matemática');

-- --------------------------------------------------------

--
-- Estrutura da tabela `dificuldade`
--

CREATE TABLE `dificuldade` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `dificuldade`
--

INSERT INTO `dificuldade` (`id`, `nome`) VALUES
(9, 'medio');

-- --------------------------------------------------------

--
-- Estrutura da tabela `histórico`
--

CREATE TABLE `histórico` (
  `id` int(11) NOT NULL,
  `partida` int(11) DEFAULT NULL,
  `aluno_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `jogo`
--

CREATE TABLE `jogo` (
  `id` int(11) NOT NULL,
  `partida` int(11) DEFAULT 0,
  `inicio` datetime DEFAULT NULL,
  `fim` datetime DEFAULT NULL,
  `pontuação` int(11) DEFAULT 0,
  `aluno_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `jogo`
--

INSERT INTO `jogo` (`id`, `partida`, `inicio`, `fim`, `pontuação`, `aluno_id`) VALUES
(90, 0, '2021-12-06 15:59:52', NULL, 20, 27),
(91, 0, '2023-01-23 14:55:29', NULL, 40, 30),
(92, 0, '2023-01-23 14:56:26', NULL, 50, 31);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `partidas`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `partidas` (
`partida` int(11)
,`número de jogadores` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pergunta`
--

CREATE TABLE `pergunta` (
  `id` int(11) NOT NULL,
  `questao` varchar(200) NOT NULL,
  `resposta1` varchar(100) NOT NULL,
  `resposta2` varchar(100) NOT NULL,
  `resposta3` varchar(45) NOT NULL,
  `resposta4` varchar(45) NOT NULL,
  `correta` int(1) DEFAULT NULL,
  `assunto_id` int(11) NOT NULL,
  `dificuldade_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pergunta`
--

INSERT INTO `pergunta` (`id`, `questao`, `resposta1`, `resposta2`, `resposta3`, `resposta4`, `correta`, `assunto_id`, `dificuldade_id`) VALUES
(20, '1+1', '2', '3', '4', '5', 1, 6, 9),
(21, '2+2', '1', '23', '4', '5', 4, 6, 9),
(22, '2+6', '2', '4', '5', '8', 4, 6, 9),
(23, 'Primeira letra de LETRA', 'L', 'E', 'T', 'R', 1, 6, 9),
(24, 'Formula da água', 'O2', 'H2O', 'H2', 'H4', 2, 6, 9);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pergunta_sorteada`
--

CREATE TABLE `pergunta_sorteada` (
  `id` int(11) NOT NULL,
  `pergunta_id` int(11) NOT NULL,
  `aluno_id` int(11) NOT NULL,
  `partida` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pergunta_sorteada`
--

INSERT INTO `pergunta_sorteada` (`id`, `pergunta_id`, `aluno_id`, `partida`) VALUES
(1419, 22, 31, 0),
(1420, 21, 27, 0),
(1421, 20, 30, 0),
(1422, 23, 27, 0),
(1423, 24, 30, 0),
(1424, 22, 31, 0),
(1425, 21, 27, 0),
(1426, 20, 30, 0),
(1427, 23, 31, 0),
(1428, 24, 27, 0),
(1429, 22, 30, 0),
(1430, 21, 27, 0),
(1431, 20, 30, 0),
(1432, 23, 31, 0),
(1433, 24, 27, 0),
(1434, 22, 30, 0),
(1435, 21, 27, 0),
(1436, 20, 30, 0),
(1437, 23, 31, 0),
(1438, 24, 27, 0),
(1439, 22, 30, 0),
(1440, 21, 31, 0),
(1441, 20, 27, 0),
(1442, 23, 30, 0),
(1443, 24, 31, 0),
(1444, 22, 27, 0),
(1445, 21, 30, 0),
(1446, 20, 31, 0),
(1447, 23, 27, 0),
(1448, 24, 30, 0),
(1449, 22, 31, 0),
(1450, 21, 27, 0),
(1451, 20, 30, 0),
(1452, 23, 31, 0),
(1453, 24, 27, 0),
(1454, 22, 30, 0),
(1455, 21, 31, 0),
(1456, 20, 27, 0),
(1457, 23, 30, 0),
(1458, 24, 31, 0),
(1459, 22, 27, 0),
(1460, 21, 30, 0),
(1461, 20, 31, 0),
(1462, 23, 27, 0),
(1463, 24, 30, 0),
(1464, 22, 31, 0),
(1465, 21, 27, 0),
(1466, 20, 30, 0),
(1467, 23, 31, 0),
(1468, 24, 27, 0),
(1469, 22, 30, 0),
(1470, 21, 31, 0),
(1471, 20, 27, 0),
(1472, 23, 30, 0),
(1473, 24, 31, 0),
(1474, 22, 27, 0),
(1475, 21, 30, 0),
(1476, 20, 31, 0),
(1477, 23, 27, 0),
(1478, 24, 30, 0),
(1479, 22, 31, 0),
(1480, 21, 27, 0),
(1481, 20, 30, 0),
(1482, 23, 31, 0),
(1483, 24, 27, 0),
(1484, 22, 30, 0),
(1485, 21, 31, 0),
(1486, 20, 27, 0),
(1487, 23, 30, 0),
(1488, 24, 31, 0),
(1489, 22, 27, 0),
(1490, 21, 30, 0),
(1491, 20, 31, 0),
(1492, 23, 27, 0),
(1493, 24, 27, 0),
(1494, 22, 30, 0),
(1495, 21, 31, 0),
(1496, 20, 27, 0),
(1497, 23, 30, 0),
(1498, 24, 31, 0),
(1499, 22, 27, 0),
(1500, 21, 30, 0),
(1501, 20, 31, 0),
(1502, 23, 27, 0),
(1503, 24, 30, 0),
(1504, 22, 31, 0),
(1505, 21, 27, 0),
(1506, 20, 30, 0),
(1507, 23, 31, 0),
(1508, 24, 27, 0),
(1509, 22, 30, 0),
(1510, 21, 31, 0),
(1511, 20, 27, 0),
(1512, 23, 30, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `prova`
--

CREATE TABLE `prova` (
  `id` int(11) NOT NULL,
  `jogo_id` int(11) NOT NULL,
  `pergunta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `ranking`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `ranking` (
`aluno_id` int(11)
,`vitórias` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `turma`
--

CREATE TABLE `turma` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `ano_letivo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `turma`
--

INSERT INTO `turma` (`id`, `nome`, `ano_letivo`) VALUES
(2, 'EI32', '2021');

-- --------------------------------------------------------

--
-- Estrutura para vista `partidas`
--
DROP TABLE IF EXISTS `partidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `partidas`  AS SELECT `jogo`.`partida` AS `partida`, count(`jogo`.`id`) AS `número de jogadores` FROM `jogo` GROUP BY `jogo`.`partida` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `ranking`
--
DROP TABLE IF EXISTS `ranking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ranking`  AS SELECT `histórico`.`aluno_id` AS `aluno_id`, count(`histórico`.`partida`) AS `vitórias` FROM `histórico` GROUP BY `histórico`.`aluno_id` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_aluno_turma1_idx` (`turma_id`);

--
-- Índices para tabela `assunto`
--
ALTER TABLE `assunto`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `dificuldade`
--
ALTER TABLE `dificuldade`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `histórico`
--
ALTER TABLE `histórico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_histórico_aluno1_idx` (`aluno_id`);

--
-- Índices para tabela `jogo`
--
ALTER TABLE `jogo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_jogo_aluno1_idx` (`aluno_id`);

--
-- Índices para tabela `pergunta`
--
ALTER TABLE `pergunta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pergunta_assunto_idx` (`assunto_id`),
  ADD KEY `fk_pergunta_dificuldade1_idx` (`dificuldade_id`);

--
-- Índices para tabela `pergunta_sorteada`
--
ALTER TABLE `pergunta_sorteada`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pergunta_sorteada_pergunta1_idx` (`pergunta_id`),
  ADD KEY `fk_pergunta_sorteada_aluno1_idx` (`aluno_id`);

--
-- Índices para tabela `prova`
--
ALTER TABLE `prova`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prova_jogo1_idx` (`jogo_id`),
  ADD KEY `fk_prova_pergunta1_idx` (`pergunta_id`);

--
-- Índices para tabela `turma`
--
ALTER TABLE `turma`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aluno`
--
ALTER TABLE `aluno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de tabela `assunto`
--
ALTER TABLE `assunto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `dificuldade`
--
ALTER TABLE `dificuldade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `histórico`
--
ALTER TABLE `histórico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `jogo`
--
ALTER TABLE `jogo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT de tabela `pergunta`
--
ALTER TABLE `pergunta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `pergunta_sorteada`
--
ALTER TABLE `pergunta_sorteada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1513;

--
-- AUTO_INCREMENT de tabela `prova`
--
ALTER TABLE `prova`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `turma`
--
ALTER TABLE `turma`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `aluno`
--
ALTER TABLE `aluno`
  ADD CONSTRAINT `fk_aluno_turma1` FOREIGN KEY (`turma_id`) REFERENCES `turma` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `histórico`
--
ALTER TABLE `histórico`
  ADD CONSTRAINT `fk_histórico_aluno1` FOREIGN KEY (`aluno_id`) REFERENCES `aluno` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `jogo`
--
ALTER TABLE `jogo`
  ADD CONSTRAINT `fk_jogo_aluno1` FOREIGN KEY (`aluno_id`) REFERENCES `aluno` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `pergunta`
--
ALTER TABLE `pergunta`
  ADD CONSTRAINT `fk_pergunta_assunto` FOREIGN KEY (`assunto_id`) REFERENCES `assunto` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pergunta_dificuldade1` FOREIGN KEY (`dificuldade_id`) REFERENCES `dificuldade` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `pergunta_sorteada`
--
ALTER TABLE `pergunta_sorteada`
  ADD CONSTRAINT `fk_pergunta_sorteada_aluno1` FOREIGN KEY (`aluno_id`) REFERENCES `aluno` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pergunta_sorteada_pergunta1` FOREIGN KEY (`pergunta_id`) REFERENCES `pergunta` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `prova`
--
ALTER TABLE `prova`
  ADD CONSTRAINT `fk_prova_jogo1` FOREIGN KEY (`jogo_id`) REFERENCES `jogo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_prova_pergunta1` FOREIGN KEY (`pergunta_id`) REFERENCES `pergunta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
