CREATE DATABASE norte_saber;
USE norte_saber;

-- 1. Tabela de Usuários
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('mentor', 'mentorado') NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabela de Áreas de Conhecimento
CREATE TABLE areas_conhecimento (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome_area VARCHAR(50) NOT NULL
);

-- 3. Tabela de Validação de Mentores (Segurança)
CREATE TABLE mentores_validacao (
    id_validacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_area INT NOT NULL,
    documento_comprovante VARCHAR(255) NOT NULL,
    status_validacao ENUM('pendente', 'aprovado', 'recusado') DEFAULT 'pendente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_area) REFERENCES areas_conhecimento(id_area)
);

-- 4. Tabela de Tópicos do Fórum (Dúvidas Rápidas)
CREATE TABLE forum_topicos (
    id_topico INT AUTO_INCREMENT PRIMARY KEY,
    id_mentorado INT NOT NULL,
    id_area INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao_duvida TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_mentorado) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_area) REFERENCES areas_conhecimento(id_area)
);

-- 5. Tabela de Respostas do Fórum
CREATE TABLE forum_respostas (
    id_resposta INT AUTO_INCREMENT PRIMARY KEY,
    id_topico INT NOT NULL,
    id_mentor INT NOT NULL,
    texto_resposta TEXT NOT NULL,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_topico) REFERENCES forum_topicos(id_topico) ON DELETE CASCADE,
    FOREIGN KEY (id_mentor) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- 6. Tabela de Agendamentos Privados
CREATE TABLE agendamentos_privados (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    id_mentorado INT NOT NULL,
    id_mentor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status_sessao ENUM('agendado', 'realizado', 'cancelado') DEFAULT 'agendado',
    canal_acesso VARCHAR(255),
    FOREIGN KEY (id_mentorado) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_mentor) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- ==========================================
-- INSERÇÃO DOS DADOS FICTÍCIOS (SPRINT 3)
-- ==========================================

-- Inserindo as Áreas de Conhecimento
INSERT INTO areas_conhecimento (nome_area) VALUES
('Jurídico'), 
('Contábil'), 
('Saúde'), 
('Negócios'), 
('Design'), 
('Tecnologia');

-- Inserindo os Usuários (Kauany + Mentorados do Fórum)
INSERT INTO usuarios (nome, email, senha, tipo_usuario) VALUES
('Kauany Silva', 'kauanydigital@gmail.com', 'hash_senha_segura', 'mentorado'),
('Mariana Lopes', 'mariana@email.com', 'hash_123', 'mentorado'),
('Roberto Fontes', 'roberto@email.com', 'hash_123', 'mentorado'),
('Juliana Meireles', 'juliana@email.com', 'hash_123', 'mentorado'),
('Tiago Carvalho', 'tiago@email.com', 'hash_123', 'mentorado'),
('Simone Andrade', 'simone@email.com', 'hash_123', 'mentorado');

-- Inserindo os Usuários (Mentores mostrados no vídeo)
INSERT INTO usuarios (nome, email, senha, tipo_usuario) VALUES
('Dr. Marcos André', 'marcos.andre@email.com', 'hash_123', 'mentor'),
('Ana Beatriz Rocha', 'ana.beatriz@email.com', 'hash_123', 'mentor'),
('Felipe Gouveia', 'felipe.gouveia@email.com', 'hash_123', 'mentor'),
('Dra. Heloisa Ramos', 'heloisa.ramos@email.com', 'hash_123', 'mentor'),
('Camila Ferreira', 'camila.ferreira@email.com', 'hash_123', 'mentor'),
('Rafael Mota', 'rafael.mota@email.com', 'hash_123', 'mentor');

-- Validando os Mentores (Ligando com suas áreas)
INSERT INTO mentores_validacao (id_usuario, id_area, documento_comprovante, status_validacao) VALUES
(7, 1, 'oab_marcos.pdf', 'aprovado'),
(8, 2, 'crc_ana.pdf', 'aprovado'),
(9, 4, 'certificado_felipe.pdf', 'aprovado'),
(10, 3, 'crm_heloisa.pdf', 'aprovado'),
(11, 5, 'portfolio_camila.pdf', 'aprovado'),
(12, 6, 'cert_rafael.pdf', 'aprovado');

-- Inserindo as Dúvidas no Fórum
INSERT INTO forum_topicos (id_mentorado, id_area, titulo, descricao_duvida) VALUES
(2, 1, 'Regularização de Confecção', 'Como regularizar uma pequena confecção em casa sem pagar impostos abusivos no início da operação?'),
(3, 2, 'Dedução de Despesas MEI', 'Preciso de ajuda com a declaração do MEI. Posso deduzir despesas com internet e conta de luz do escritório em casa?'),
(4, 1, 'Problema Trabalhista Freelancer', 'Contratei um freelancer sem contrato e ele está me cobrando indenização trabalhista. O que devo fazer?'),
(5, 4, 'Vendas sem CNPJ', 'Quero vender meus produtos no Instagram e WhatsApp. Preciso de CNPJ ou posso fazer como pessoa física mesmo?'),
(6, 3, 'Notificação Vigilância Sanitária', 'Recebi uma notificação da vigilância sanitária para o meu delivery caseiro. Quais são os procedimentos para regularizar?');

-- Inserindo o Agendamento feito no vídeo
INSERT INTO agendamentos_privados (id_mentorado, id_mentor, data_hora, status_sessao, canal_acesso) VALUES
(1, 9, '2026-06-16 11:30:00', 'agendado', 'https://meet.google.com/abc-defg-hij');