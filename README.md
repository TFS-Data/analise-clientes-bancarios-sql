# Análise de Clientes Bancários

**Objetivo:** gerar insights financeiros e identificar possíveis riscos de crédito.

---

## Visão Geral

Este projeto apresenta uma análise exploratória de dados no contexto bancário, com foco em entender o comportamento financeiro dos clientes, identificar perfis de alto valor e detectar possíveis riscos de inadimplência.

---

## Análises

### 1. Base Analítica (Cruzamento de Dados)

**Objetivo:** juntar dados de clientes com suas transações

```sql
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
```

---

### 2. Total Gasto por Cliente

**Objetivo:** identificar quais clientes movimentam mais dinheiro

```sql
SELECT 
    c.id_cliente,
    SUM(t.valor) AS total_movimentado
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente
ORDER BY total_movimentado DESC;
```

---

### 3. Valor Médio das Transações por Cliente

**Objetivo:** entender o comportamento de consumo de cada cliente

```sql
SELECT 
    c.id_cliente,
    AVG(t.valor) AS valor_medio
FROM clientes c
JOIN transacoes t 
    ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente;
```

---

### 4. Total por Tipo de Transação (Crédito vs Débito)

**Objetivo:** entender como os clientes utilizam o dinheiro

```sql
SELECT 
    tipo,
    SUM(valor) AS total
FROM transacoes
GROUP BY tipo;
```

---

### 5. Identificação de Clientes de Alto Valor

**Objetivo:** encontrar clientes com grande movimentação financeira

```sql
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
```

---

### 6. Identificação de Clientes com Possível Risco de Crédito

**Objetivo:** detectar clientes com baixo score e alto consumo

> Nesta análise, o filtro é aplicado antes da agregação para melhorar a performance da consulta.

```sql
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
```

---

## Conclusão

A análise dos dados permitiu identificar padrões relevantes no comportamento financeiro dos clientes.

Foi possível observar diferenças claras entre clientes com alta movimentação financeira e aqueles com menor volume de transações, permitindo uma primeira segmentação baseada em valor.

Além disso, a combinação entre score de crédito e volume de gastos possibilitou a identificação de clientes com potencial risco de inadimplência, o que pode ser utilizado como critério para revisão de limites e concessão de crédito.

Com base nesses insights, o banco pode direcionar melhor suas estratégias, tanto para retenção de clientes de alto valor quanto para mitigação de riscos associados a perfis mais sensíveis.

Este tipo de análise é essencial para apoiar decisões orientadas por dados no contexto financeiro.

---

## Glossário de Termos

**Score de crédito**  
Indicador que representa a probabilidade de um cliente pagar suas dívidas em dia. Quanto maior o score, menor o risco de inadimplência.

**Renda**  
Valor mensal que o cliente recebe, utilizado para avaliar sua capacidade financeira.

**Tempo de conta**  
Quantidade de meses que o cliente possui relacionamento com o banco.

**Valor da transação**  
Quantia movimentada em cada operação financeira realizada pelo cliente.

**Tipo de transação (crédito/débito)**  
Crédito: entrada de dinheiro  
Débito: saída de dinheiro  

**Valor médio das transações**  
Média dos valores gastos por um cliente em suas transações, indicando seu padrão de consumo.
