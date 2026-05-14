CREATE VIEW IF NOT EXISTS vw_equipment_daily_losses_long AS
WITH accumulated AS (
    SELECT
        loss_date,
        war_day,
        equipment_type,
        accumulated_quantity,
        LAG(accumulated_quantity) OVER (
            PARTITION BY equipment_type
            ORDER BY loss_date
        ) AS previous_accumulated_quantity
    FROM
        vw_equipment_losses_long
)

SELECT
    loss_date,
    war_day,
    equipment_type,
    accumulated_quantity,
    accumulated_quantity - previous_accumulated_quantity AS daily_quantity_lost
FROM
    accumulated
WHERE
    previous_accumulated_quantity IS NOT NULL;