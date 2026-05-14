SELECT
    equipment_type,
    ROUND(AVG(daily_quantity_lost), 2) AS avg_daily_losses
FROM
    vw_equipment_daily_losses_long
GROUP BY
    equipment_type
ORDER BY
    avg_daily_losses DESC;