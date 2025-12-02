use Hospital;
-- PERGUNTA 1: Lista de todos os pacientes cadastrados, incluindo nome, sexo e data de nascimento, ordenada alfabeticamente.
SELECT nome, sexo, data_nascimento
FROM Paciente
ORDER BY nome;

-- PERGUNTA 2: Quantas consultas foram realizadas no total?
SELECT COUNT(*) AS total_consultas
FROM Consulta;

-- PERGUNTA 3: Qual é o remédio com a maior quantidade em estoque?
SELECT r.nome, e.quantidade
FROM Remedio r
JOIN Estoque e ON r.id_remedio = e.id_remedio
ORDER BY e.quantidade DESC
LIMIT 1;

-- PERGUNTA 4: Liste os funcionários que são médicos, incluindo nome e CRM.
SELECT f.nome, f.crm
FROM Funcionario f
JOIN Cargo c ON f.id_cargo = c.id_cargo
WHERE c.nome = 'Médico';

-- PERGUNTA 5: Quantas receitas foram emitidas por cada médico?
SELECT f.nome, COUNT(r.id_receita) AS total_receitas
FROM Funcionario f
LEFT JOIN Receita r ON f.id_funcionario = r.id_funcionario
WHERE f.id_cargo = (SELECT id_cargo FROM Cargo WHERE nome = 'Médico')
GROUP BY f.id_funcionario, f.nome;

-- PERGUNTA 6: Qual é a média de temperatura nas consultas realizadas?
SELECT AVG(temperatura) AS media_temperatura
FROM Consulta;

-- PERGUNTA 7: Liste os remédios que estão com validade até dezembro de 2025.
SELECT r.nome, e.data_validade
FROM Remedio r
JOIN Estoque e ON r.id_remedio = e.id_remedio
WHERE e.data_validade <= '2025-12-31';

-- PERGUNTA 8: Quantos funcionários existem por cargo?
SELECT c.nome AS cargo, COUNT(f.id_funcionario) AS total_funcionarios
FROM Cargo c
LEFT JOIN Funcionario f ON c.id_cargo = f.id_cargo
GROUP BY c.id_cargo, c.nome;

-- PERGUNTA 9: Qual é o paciente com a consulta mais recente?
SELECT p.nome, c.data_hora
FROM Paciente p
JOIN Consulta c ON p.id_paciente = c.id_paciente
ORDER BY c.data_hora DESC
LIMIT 1;

-- PERGUNTA 10: Liste as consultas com pressão arterial acima de 120/80, incluindo nome do paciente e diagnóstico.
SELECT p.nome, c.diagnostico, c.pressao
FROM Paciente p
JOIN Consulta c ON p.id_paciente = c.id_paciente
WHERE c.pressao > '120/80';

-- PERGUNTA 11: Qual é a soma total de quantidades em estoque de todos os remédios?
SELECT SUM(e.quantidade) AS total_quantidade
FROM Estoque e;

-- PERGUNTA 12: Liste os remédios prescritos em uma receita específica (id_receita = 1), incluindo quantidade e dosagem.
SELECT r.nome, rr.quantidade, rr.dosagem
FROM Remedio r
JOIN Receita_Remedio rr ON r.id_remedio = rr.id_remedio
WHERE rr.id_receita = 1;

-- PERGUNTA 13: Quantas salas estão associadas a funcionários?
SELECT COUNT(*) AS salas_ocupadas
FROM Sala
WHERE id_funcionario IS NOT NULL;

-- PERGUNTA 14: Qual é o médico que realizou mais consultas?
SELECT f.nome, COUNT(c.id_consulta) AS total_consultas
FROM Funcionario f
JOIN Consulta c ON f.id_funcionario = c.id_funcionario
WHERE f.id_cargo = (SELECT id_cargo FROM Cargo WHERE nome = 'Médico')
GROUP BY f.id_funcionario, f.nome
ORDER BY total_consultas DESC
LIMIT 1;

-- PERGUNTA 15: Liste os pacientes que nasceram após 1990, ordenados por data de nascimento.
SELECT nome, data_nascimento
FROM Paciente
WHERE data_nascimento > '1990-01-01'
ORDER BY data_nascimento;

-- PERGUNTA 16: Qual é a frequência cardíaca máxima registrada em consultas?
SELECT MAX(frequencia_cardiaca) AS max_frequencia
FROM Consulta;

-- PERGUNTA 17: Liste as receitas emitidas em setembro de 2025, incluindo nome do paciente e médico.
-- ATENÇÃO: As funções MONTH() e YEAR() são típicas do MySQL. Em PostgreSQL, você usaria EXTRACT(MONTH FROM r.data_emissao) = 9 e EXTRACT(YEAR FROM r.data_emissao) = 2025.
SELECT p.nome AS paciente, f.nome AS medico, r.data_emissao
FROM Receita r
JOIN Paciente p ON r.id_paciente = p.id_paciente
JOIN Funcionario f ON r.id_funcionario = f.id_funcionario
WHERE MONTH(r.data_emissao) = 9 AND YEAR(r.data_emissao) = 2025;

-- PERGUNTA 18: Quantos remédios têm quantidade em estoque menor que 100?
SELECT COUNT(*) AS remedios_baixo_estoque
FROM Estoque
WHERE quantidade < 100;

-- PERGUNTA 19: Liste os funcionários com telefone cadastrado, agrupados por UF.
-- ATENÇÃO: GROUP_CONCAT é uma função específica do MySQL. Em PostgreSQL, use STRING_AGG(nome, ',').
SELECT uf, GROUP_CONCAT(nome) AS funcionarios
FROM Funcionario
WHERE telefone IS NOT NULL
GROUP BY uf;

-- PERGUNTA 20: Qual é a receita mais recente emitida?
SELECT id_receita, data_emissao
FROM Receita
ORDER BY data_emissao DESC
LIMIT 1;

-- PERGUNTA 21: Liste as consultas realizadas em uma sala específica (id_sala = 1), incluindo nome do paciente.
SELECT p.nome, c.data_hora
FROM Paciente p
JOIN Consulta c ON p.id_paciente = c.id_paciente
WHERE c.id_sala = 1;

-- PERGUNTA 22: Qual é a média de idade dos pacientes?
-- ATENÇÃO: A função YEAR(CURDATE()) - YEAR(data_nascimento) é uma forma simplificada de calcular a idade em MySQL. Para maior precisão, o DATEDIFF em dias é mais adequado ou DATE_PART em PostgreSQL.
SELECT AVG(YEAR(CURDATE()) - YEAR(data_nascimento)) AS media_idade
FROM Paciente;

-- PERGUNTA 23: Liste os remédios que não foram prescritos em nenhuma receita.
SELECT r.nome
FROM Remedio r
LEFT JOIN Receita_Remedio rr ON r.id_remedio = rr.id_remedio
WHERE rr.id_receita IS NULL;

-- PERGUNTA 24: Quantas consultas foram realizadas por cada paciente?
SELECT p.nome, COUNT(c.id_consulta) AS total_consultas
FROM Paciente p
LEFT JOIN Consulta c ON p.id_paciente = c.id_paciente
GROUP BY p.id_paciente, p.nome;

-- PERGUNTA 25: Qual é o remédio com a data de validade mais próxima?
SELECT r.nome, e.data_validade
FROM Remedio r
JOIN Estoque e ON r.id_remedio = e.id_remedio
ORDER BY e.data_validade ASC
LIMIT 1;

-- PERGUNTA 26: Liste os funcionários que são enfermeiros, incluindo nome e COREN.
SELECT f.nome, f.coren
FROM Funcionario f
JOIN Cargo c ON f.id_cargo = c.id_cargo
WHERE c.nome = 'Enfermeiro';

-- PERGUNTA 27: Qual é a soma das quantidades prescritas de um remédio específico (id_remedio = 1) em todas as receitas?
-- ATENÇÃO: O CAST é necessário aqui porque a coluna 'quantidade' em Receita_Remedio pode estar armazenando valores como '10 comprimidos'. Se a coluna for puramente numérica, remova o CAST.
SELECT SUM(CAST(rr.quantidade AS UNSIGNED)) AS total_prescrito
FROM Receita_Remedio rr
WHERE rr.id_remedio = 1;

-- PERGUNTA 28: Liste as consultas sem receita associada, incluindo diagnóstico.
SELECT c.diagnostico, c.data_hora
FROM Consulta c
WHERE c.id_receita IS NULL;

-- PERGUNTA 29: Quantos usuários estão habilitados no sistema?
SELECT COUNT(*) AS usuarios_habilitados
FROM usuario
WHERE enabled = TRUE;

-- PERGUNTA 30: Qual é o paciente mais jovem cadastrado?
SELECT nome, data_nascimento
FROM Paciente
ORDER BY data_nascimento DESC
LIMIT 1;