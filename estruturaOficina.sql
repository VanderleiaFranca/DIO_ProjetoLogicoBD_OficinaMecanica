CREATE DATABASE IF NOT EXISTS oficina_mecanica CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE oficina_mecanica;

-- Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150)
);

-- Veículo
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa CHAR(7) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Mecânico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    especialidade VARCHAR(50)
);

-- Equipe
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    nomeEquipe VARCHAR(100) NOT NULL
);

-- EquipeMecanico (N:N)
CREATE TABLE EquipeMecanica (
    idEquipeMecanica INT AUTO_INCREMENT PRIMARY KEY,
    idEquipe INT NOT NULL,
    idMecanico INT NOT NULL,
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe),
    FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Ordem de Serviço
CREATE TABLE OrdemServico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    dataEmissao DATE NOT NULL,
    dataConclusao DATE,
    status ENUM('aberta', 'autorizada', 'concluida', 'cancelada') DEFAULT 'aberta',
    valorTotal DECIMAL(10,2) DEFAULT 0.00,
    autorizada BOOLEAN DEFAULT FALSE,
    idVeiculo INT NOT NULL,
    idEquipe INT NOT NULL,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- Serviço
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valorMaoDeObra DECIMAL(10,2) NOT NULL
);

-- OSServico (N:N)
CREATE TABLE ExecucaoServico (
    idExecucaoServico INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    idServico INT NOT NULL,
    quantidade INT DEFAULT 1,
    subTotalServico DECIMAL(10,2),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- Peça
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    nomePeca VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100),
    valorPeca DECIMAL(10,2) NOT NULL
);

-- OSPeca (N:N)
CREATE TABLE PecaUsadaOS (
    idPecaUsadaOS INT AUTO_INCREMENT PRIMARY KEY,
    idOrdemServico INT NOT NULL,
    idPeca INT NOT NULL,
    quantidade INT DEFAULT 1,
    subTotalPeca DECIMAL(10,2),
    FOREIGN KEY (idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);