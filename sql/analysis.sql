/*
============================================================
ANALYTICAL QUERIES
============================================================

As consultas abaixo utilizam principalmente a view:

    vw_equipment_daily_losses_long

Essa view representa as perdas diárias por tipo de equipamento,
calculadas a partir dos valores acumulados da tabela original.
*/


/*
============================================================
1. MAX LOSSES PER EQUIPMENT
============================================================

Objetivo:
Identificar a maior perda diária registrada para cada tipo de
equipamento.

Exemplo:
Se em um determinado dia foram perdidos 40 tanques, e esse foi
o maior valor diário para "tank", essa consulta retorna 40.
*/

SELECT
    equipment_type,
    MAX(daily_quantity_lost) AS max_daily_loss
FROM
    vw_equipment_daily_losses_long
GROUP BY
    equipment_type
ORDER BY
    max_daily_loss DESC;


/*
============================================================
2. AVERAGE DAILY LOSSES PER EQUIPMENT
============================================================

Objetivo:
Calcular a média diária de perdas para cada tipo de equipamento.

Essa consulta ajuda a entender quais equipamentos apresentam
maior volume médio de perda ao longo do período analisado.
*/

SELECT
    equipment_type,
    ROUND(AVG(daily_quantity_lost), 2) AS avg_daily_losses
FROM
    vw_equipment_daily_losses_long
GROUP BY
    equipment_type
ORDER BY
    avg_daily_losses DESC;