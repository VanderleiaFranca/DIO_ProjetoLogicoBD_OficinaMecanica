-- Criação do Banco de Dados para o cenário de Oficina Mecânica
create database oficinaMecanica;
use oficinaMecanica;

-- ==========================
-- Criação da Tabela Cliente
-- ==========================
create table Cliente (
    idCliente int auto_increment primary key,
    primeiroNome varchar(50) not null,
    sobrenome varchar(50) not null,
    telefone varchar(20) not null,
    email varchar(30),
	logradouro varchar(50),
    numero varchar(10),
    complemento varchar(50),
    bairro varchar(30),
    cidade varchar(30),
    estado varchar(20),
    cep varchar(10) not null,
    tipoCliente enum('F', 'J') not null,
    cpf char(15) unique,
    cnpj char(20) unique,
    check (
        (tipoCliente = 'F' and cpf is not null and cnpj is null) or
        (tipoCliente = 'J' and cnpj is not null and cpf is null)
    )
);
alter table Cliente auto_increment = 1;
-- desc Cliente;

-- ==========================
-- Criação da Tabela Veículo
-- ==========================
create table Veiculo (
    idVeiculo int auto_increment primary key,
    placa char(10) unique not null,
    modelo varchar(30),
    marca varchar(30),
    ano date,
    idCliente int not null,
    foreign key(idCliente) references Cliente(idCliente)
);

-- ===========================
-- Criação da Tabela Mecânico
-- ===========================
create table Mecanico (
    idMecanico int auto_increment primary key,
    primeiroNome varchar(50) not null,
    sobrenome varchar(50) not null,
    especialidade varchar(50),
    contato varchar(15)
);

-- =========================
-- Criação da Tabela Equipe
-- =========================
create table Equipe (
    idEquipe int auto_increment primary key,
    nomeEquipe varchar(45) not null
);

-- =================
-- Ordem de Serviço
-- =================
create table OrdemServico (
    idOrdemServico int auto_increment primary key,
    dataEmissao date not null,
    dataConclusao date,
    status enum('ABERTA', 'AUTORIZADA', 'CONCLUIDA', 'CANCELADA') default 'ABERTA',
    valorTotal float default 0.00,
    autorizada boolean default false,
    idVeiculo int not null,
    idEquipe int not null,
    foreign key (idVeiculo) references Veiculo(idVeiculo),
    foreign key (idEquipe) references Equipe(idEquipe)
);

-- ==========================
-- Criação da Tabela Serviço
-- ==========================
create table Servico (
    idServico int auto_increment primary key,
    descricao text(255),
    valorMaoDeObra float default 0.00
);

-- =======================
-- Criação da Tabela Peça
-- =======================
create table Peca (
    idPeca int auto_increment primary key,
    nomePeca varchar(45) unique,
    fabricante varchar(45),
    valorPeca float not null
);

-- ==========================================
-- Equipe Mecanica (Equipe ↔ Mecânico) (N:N)
-- ==========================================
create table EquipeMecanica (
    idEquipeMecanica int auto_increment primary key,
    idEquipe int not null,
    idMecanico int not null,
    foreign key (idEquipe) references Equipe(idEquipe),
    foreign key (idMecanico) references Mecanico(idMecanico)
);

-- =========================================================================
-- Criação da Tabela Execucao do Servico (Ordem de Serviço ↔ Serviço) (N:N)
-- =========================================================================
create table ExecucaoServico (
    idExecucaoServico int auto_increment primary key,
    idOrdemServico int not null,
    idServico int not null,
    idVeiculo int not null,
    idEquipe int not null,
    subTotalServico float,
    foreign key (idOrdemServico) references OrdemServico(idOrdemServico),
    foreign key (idServico) references Servico(idServico),
    foreign key (idVeiculo) references Veiculo(idVeiculo),
    foreign key (idEquipe) references Equipe(idEquipe)
);

-- ===================================================================
-- Criação da Tabela Peca Usada na OS (Ordem de Serviço ↔ Peça) (N:N)
-- ===================================================================
create table PecaUsadaOS (
    idPecaUsadaOS int auto_increment primary key,
    idOrdemServico int not null,
    idPeca int not null,
    idVeiculo int not null,
    idEquipe int not null,
    quantidade int default 1,
    subTotalPeca float,
    foreign key (idOrdemServico) references OrdemServico(idOrdemServico),
    foreign key (idPeca) references Peca(idPeca),
    foreign key (idVeiculo) references Veiculo(idVeiculo),
    foreign key (idEquipe) references Equipe(idEquipe)
);