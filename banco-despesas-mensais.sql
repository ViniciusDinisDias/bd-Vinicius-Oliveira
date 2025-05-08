-- Criação do Banco de dados do Projeto 
create database if not exists despesas_mensais;
use despesas_mensais;
-- Tabela de Usuário:
CREATE TABLE Usuario (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(100) not null,
    email varchar(100) not null unique,
    senha varchar(100) not null
);

-- Tabela de Despesas dos Usuários:
CREATE TABLE Despesa (
	id_despesa int auto_increment primary key,
    id_usuario int not null,
    id_categoria int not null,
    valor decimal(10,2) not null,
    data date not null,
    data_vencimento enum('Pago', 'Pendente') not null,
    descricao text
    
);

-- Tabela de Categoria da Despesa:
CREATE TABLE Categoria (
	id_categoria int auto_increment primary key,
    nome varchar(50) not null unique
);

-- Tabela de notificações de vencimento de contas:
CREATE TABLE Notificacao (
	id_notificacao int auto_increment primary key,
    id_usuario int not null, 
    id_despesa int not null, 
    mensagem text not null,
    data_envio datetime not null
)
