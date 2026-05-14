/*
============================================================
ANALYTICAL VIEWS
============================================================

Este arquivo cria views analíticas sobre a tabela:

    russia_losses_equipment

A tabela original possui valores acumulados por dia.
As views abaixo ajudam a analisar os dados em dois formatos:

1. Formato largo:
   - Uma linha por dia
   - Uma coluna diária para cada equipamento

2. Formato longo:
   - Uma linha por dia por equipamento
   - Melhor para análises, rankings, gráficos e Power BI
*/


/*
============================================================
1. EQUIPMENT LOSSES LONG
============================================================

Objetivo:
Transformar a tabela original, que possui uma coluna para cada
equipamento, em um formato vertical.

Formato final:

    loss_date
    war_day
    equipment_type
    accumulated_quantity
*/

DROP VIEW IF EXISTS vw_equipment_losses_long;

CREATE VIEW vw_equipment_losses_long AS

SELECT
    loss_date,
    war_day,
    'aircraft' AS equipment_type,
    aircraft AS accumulated_quantity
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'helicopter',
    helicopter
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'tank',
    tank
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'apc',
    apc
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'field_artillery',
    field_artillery
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'mrl',
    mrl
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'military_auto',
    military_auto
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'fuel_tank',
    fuel_tank
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'drone',
    drone
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'naval_ship',
    naval_ship
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'anti_aircraft_warfare',
    anti_aircraft_warfare
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'special_equipment',
    special_equipment
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'mobile_srbm_system',
    mobile_srbm_system
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'vehicles_and_fuel_tanks',
    vehicles_and_fuel_tanks
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'cruise_missiles',
    cruise_missiles
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'submarines',
    submarines
FROM
    russia_losses_equipment

UNION ALL

SELECT
    loss_date,
    war_day,
    'ground_robotic_systems',
    ground_robotic_systems
FROM
    russia_losses_equipment;


/*
============================================================
2. EQUIPMENT DAILY LOSSES LONG
============================================================

Objetivo:
Calcular a perda diária por tipo de equipamento a partir dos
valores acumulados.

Cálculo:

    acumulado do dia atual - acumulado do dia anterior

Essa é a view mais indicada para análises, rankings e dashboards.
*/

DROP VIEW IF EXISTS vw_equipment_daily_losses_long;

CREATE VIEW vw_equipment_daily_losses_long AS

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


/*
============================================================
3. DAILY EQUIPMENT LOSSES WIDE
============================================================

Objetivo:
Calcular a perda diária por equipamento em formato largo.

Formato final:

    loss_date
    war_day
    aircraft_daily
    helicopter_daily
    tank_daily
    ...

Essa view é útil para conferência rápida, mas o formato long
costuma ser melhor para análises e dashboards.
*/

DROP VIEW IF EXISTS vw_daily_equipment_losses;

CREATE VIEW vw_daily_equipment_losses AS

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