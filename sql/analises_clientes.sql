-- =====================================================
-- ANÁLISE DE CLIENTES BANCÁRIOS
-- Autor: Thiago
-- =====================================================


-- =====================================================
-- 1. BASE ANALÍTICA (CRUZAMENTO DE DADOS)
-- Objetivo: juntar dados de clientes com suas transações
-- =====================================================

SELECT 
    c.id_cliente,
    c.idade,
    c.renda,
    c.tempo_conta_meses,
    c.score_credito,
    t.valor,
    t.tipo,
    t.data
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente;



-- =====================================================
-- 2. TOTAL GASTO POR CLIENTE
-- Objetivo: identificar quais clientes movimentam mais dinheiro
-- =====================================================

SELECT 
    c.id_cliente,
    SUM(t.valor) AS total_movimentado
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente
ORDER BY total_movimentado DESC;



-- =====================================================
-- 3. VALOR MÉDIO DAS TRANSAÇÕES POR CLIENTE
-- Objetivo: entender o comportamento de consumo de cada cliente
-- =====================================================

SELECT 
    c.id_cliente,
    AVG(t.valor) AS valor_medio
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente;



-- =====================================================
-- 4. TOTAL POR TIPO DE TRANSAÇÃO (CRÉDITO VS DÉBITO)
-- Objetivo: entender como os clientes utilizam o dinheiro
-- =====================================================

SELECT 
    tipo,
    SUM(valor) AS total
FROM transacoes
GROUP BY tipo;



-- =====================================================
-- 5. IDENTIFICAÇÃO DE CLIENTES DE ALTO VALOR
-- Objetivo: encontrar clientes com grande movimentação financeira
-- =====================================================

SELECT 
    c.id_cliente,
    c.renda,
    SUM(t.valor) AS total_movimentado
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente, c.renda
HAVING SUM(t.valor) > 20000
ORDER BY total_movimentado DESC;



-- =====================================================
-- 6. IDENTIFICAÇÃO DE CLIENTES COM POSSÍVEL RISCO DE CRÉDITO
-- Objetivo: detectar clientes com baixo score e alto consumo
-- =====================================================

SELECT 
    c.id_cliente,
    c.score_credito,
    SUM(t.valor) AS total_gasto
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
WHERE c.score_credito < 600
GROUP BY c.id_cliente, c.score_credito
ORDER BY total_gasto DESC;
