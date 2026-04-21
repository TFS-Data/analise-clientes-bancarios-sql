CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    idade INT,
    renda DECIMAL(10,2),
    tempo_conta_meses INT,
    score_credito INT
);

CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY,
    id_cliente INT,
    valor DECIMAL(10,2),
    tipo VARCHAR(10),
    data DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
