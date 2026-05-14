CREATE VIEW IF NOT EXISTS vw_daily_equipment_losses AS
WITH daily_losses AS (
    SELECT
        loss_date,
        war_day,

        aircraft - LAG(aircraft) OVER (ORDER BY loss_date) AS aircraft_daily,
        helicopter - LAG(helicopter) OVER (ORDER BY loss_date) AS helicopter_daily,
        tank - LAG(tank) OVER (ORDER BY loss_date) AS tank_daily,
        apc - LAG(apc) OVER (ORDER BY loss_date) AS apc_daily,
        field_artillery - LAG(field_artillery) OVER (ORDER BY loss_date) AS field_artillery_daily,
        mrl - LAG(mrl) OVER (ORDER BY loss_date) AS mrl_daily,
        military_auto - LAG(military_auto) OVER (ORDER BY loss_date) AS military_auto_daily,
        fuel_tank - LAG(fuel_tank) OVER (ORDER BY loss_date) AS fuel_tank_daily,
        drone - LAG(drone) OVER (ORDER BY loss_date) AS drone_daily,
        naval_ship - LAG(naval_ship) OVER (ORDER BY loss_date) AS naval_ship_daily,
        anti_aircraft_warfare - LAG(anti_aircraft_warfare) OVER (ORDER BY loss_date) AS anti_aircraft_warfare_daily,
        special_equipment - LAG(special_equipment) OVER (ORDER BY loss_date) AS special_equipment_daily,
        mobile_srbm_system - LAG(mobile_srbm_system) OVER (ORDER BY loss_date) AS mobile_srbm_system_daily,
        vehicles_and_fuel_tanks - LAG(vehicles_and_fuel_tanks) OVER (ORDER BY loss_date) AS vehicles_and_fuel_tanks_daily,
        cruise_missiles - LAG(cruise_missiles) OVER (ORDER BY loss_date) AS cruise_missiles_daily,
        submarines - LAG(submarines) OVER (ORDER BY loss_date) AS submarines_daily,
        ground_robotic_systems - LAG(ground_robotic_systems) OVER (ORDER BY loss_date) AS ground_robotic_systems_daily

    FROM
        russia_losses_equipment
)

SELECT
    *
FROM
    daily_losses
WHERE
    war_day > 1;