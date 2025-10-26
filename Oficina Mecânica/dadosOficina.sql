use oficinaMecanica;

-- =======================
-- Tabela Cliente
-- =======================
insert into Cliente (primeiroNome, sobrenome, telefone, email, logradouro, numero, complemento, bairro, cidade, estado, cep, tipoCliente, cpf, cnpj)
values
('Carlos', 'Silva', '11987654321', 'carlos.silva@email.com', 'Rua das Flores', '123', 'Casa', 'Centro', 'São Paulo', 'SP', '01010-000', 'F', '123.456.789-00', null),
('Maria', 'Oliveira', '21991234567', 'maria.oliveira@email.com', 'Av. Atlântica', '456', 'Apto 202', 'Copacabana', 'Rio de Janeiro', 'RJ', '22010-000', 'F', '987.654.321-00', null),
('João', 'Souza', '31990011222', 'joao.souza@empresa.com', 'Rua Minas Gerais', '789', null, 'Savassi', 'Belo Horizonte', 'MG', '30110-000', 'J', null, '12.345.678/0001-99'),
('Fernanda', 'Lima', '11988776655', 'fernanda.lima@email.com', 'Rua do Sol', '321', null, 'Jardins', 'São Paulo', 'SP', '01410-000', 'F', '456.789.123-00', null);

-- =======================
-- Tabela Veiculo
-- =======================
insert into Veiculo (placa, modelo, marca, ano, idCliente)
values
('ABC1A23', 'Civic', 'Honda', '2018-01-01', 1),
('XYZ9B87', 'Corolla', 'Toyota', '2020-01-01', 2),
('JKL4C56', 'HB20', 'Hyundai', '2019-01-01', 3),
('DEF7D89', 'Onix', 'Chevrolet', '2021-01-01', 4);

-- =======================
-- Tabela Mecanico
-- =======================
insert into Mecanico (primeiroNome, sobrenome, especialidade, contato)
values
('Rafael', 'Costa', 'Motor e Suspensão', '11995554433'),
('Bruno', 'Pereira', 'Freios', '11997778899'),
('Lucas', 'Mendes', 'Elétrica', '21991112233'),
('Thiago', 'Souza', 'Ar Condicionado', '31992223344');

-- =======================
-- Tabela Equipe
-- =======================
insert into Equipe (nomeEquipe)
values
('Equipe Alfa'),
('Equipe Beta');

-- =======================
-- Tabela EquipeMecanica 
-- =======================
insert into EquipeMecanica (idEquipe, idMecanico)
values
(1, 1),
(1, 2),
(2, 3),
(2, 4);

-- =======================
-- Tabela Servico
-- =======================
insert into Servico (descricao, valorMaoDeObra)
values
('Troca de óleo', 100.00),
('Revisão completa', 500.00),
('Troca de pastilhas de freio', 200.00),
('Alinhamento e balanceamento', 150.00),
('Reparo elétrico', 300.00);

-- =======================
-- Tabela Peca
-- =======================
insert into Peca (nomePeca, fabricante, valorPeca)
values
('Filtro de óleo', 'Bosch', 50.00),
('Pastilha de freio', 'Fras-le', 120.00),
('Bateria 60Ah', 'Moura', 400.00),
('Pneu Aro 15', 'Pirelli', 350.00),
('Correia dentada', 'Gates', 180.00);

-- ========================
-- Tabela Ordem de Servico
-- ========================
insert into OrdemServico (dataEmissao, dataConclusao, status, valorTotal, autorizada, idVeiculo, idEquipe)
values
('2024-05-01', '2024-05-03', 'CONCLUIDA', 870.00, true, 1, 1),
('2024-06-10', null, 'ABERTA', 0.00, false, 2, 2),
('2024-06-15', '2024-06-20', 'CONCLUIDA', 950.00, true, 3, 1),
('2024-07-02', '2024-07-05', 'CONCLUIDA', 400.00, true, 4, 2);

-- ===========================
-- Tabela Execucao do Servico
-- ===========================
insert into ExecucaoServico (idOrdemServico, idServico, idVeiculo, idEquipe, subTotalServico)
values
(1, 1, 1, 1, 100.00),
(1, 3, 1, 1, 200.00),
(1, 4, 1, 1, 150.00),
(3, 2, 3, 1, 500.00),
(3, 5, 3, 1, 300.00),
(4, 1, 4, 2, 100.00);

-- ========================
-- Tabela Peca Usada na OS
-- ========================
insert into PecaUsadaOS (idOrdemServico, idPeca, idVeiculo, idEquipe, quantidade, subTotalPeca)
values
(1, 1, 1, 1, 1, 50.00),
(1, 2, 1, 1, 1, 120.00),
(3, 3, 3, 1, 1, 400.00),
(3, 5, 3, 1, 1, 180.00),
(4, 4, 4, 2, 1, 350.00);

-- Listar todas as ordens de serviço com cliente e veículo
select os.idOrdemServico, c.primeiroNome, v.modelo, os.status, os.valorTotal
from OrdemServico os
join Veiculo v on os.idVeiculo = v.idVeiculo
join Cliente c on v.idCliente = c.idCliente;

-- Mostrar os serviços realizados em cada OS
select os.idOrdemServico, s.descricao, es.subTotalServico
from ExecucaoServico es
join Servico s on es.idServico = s.idServico
join OrdemServico os on es.idOrdemServico = os.idOrdemServico;

-- Calcular o total de peças usadas por OS
select os.idOrdemServico, sum(pu.subTotalPeca) as totalPecas
from PecaUsadaOS pu
join OrdemServico os on pu.idOrdemServico = os.idOrdemServico
group by os.idOrdemServico;

-- Mostrar quais mecânicos participam de cada equipe
select e.nomeEquipe, m.primeiroNome, m.especialidade
from EquipeMecanica em
join Equipe e on em.idEquipe = e.idEquipe
join Mecanico m on em.idMecanico = m.idMecanico;