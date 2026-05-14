SELECT
    equipment_type,
    MAX(daily_quantity_lost) AS max_daily_loss
FROM
    vw_equipment_daily_losses_long
GROUP BY
    equipment_type
ORDER BY
    max_daily_loss DESC;