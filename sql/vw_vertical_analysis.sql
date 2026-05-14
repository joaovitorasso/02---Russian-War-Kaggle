CREATE VIEW IF NOT EXISTS vw_equipment_losses_long AS

SELECT loss_date, war_day, 'aircraft' AS equipment_type, aircraft AS accumulated_quantity
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'helicopter', helicopter
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'tank', tank
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'apc', apc
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'field_artillery', field_artillery
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'mrl', mrl
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'military_auto', military_auto
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'fuel_tank', fuel_tank
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'drone', drone
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'naval_ship', naval_ship
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'anti_aircraft_warfare', anti_aircraft_warfare
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'special_equipment', special_equipment
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'mobile_srbm_system', mobile_srbm_system
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'vehicles_and_fuel_tanks', vehicles_and_fuel_tanks
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'cruise_missiles', cruise_missiles
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'submarines', submarines
FROM russia_losses_equipment

UNION ALL

SELECT loss_date, war_day, 'ground_robotic_systems', ground_robotic_systems
FROM russia_losses_equipment;