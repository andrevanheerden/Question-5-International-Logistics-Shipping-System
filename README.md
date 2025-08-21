

# Question-5-International-Logistics-Shipping-System

# Group

Keabetswe Olifant_241299
Andre van Heerden_241155

# What is the Assinment

create a logistics company that manages shipments between countries. The shipment contains multiple items per shipment and each item has a client. Each shipment will have a customs officer that is assigned to the shipment and this officer will clear the shipment or not clear it. Shipments have a transportMode that has the transport type and gets data from transportLog and delays. The delays will update if a shipment was delayed and why. The transport logs will log the location and time of a transport if they reach a checkpoint in there journey.

## ER daigram 



## Joins

Join 1: description:
```
SELECT
    shipment.id,
    COUNT(transport_log.checkpoint_location_id) AS countries_visited,
    transport_mode.vehicle_type
FROM transport_log
INNER JOIN shipment 
    ON shipment.id = transport_log.shipment_id
INNER JOIN transport_mode 
    ON transport_mode.id = shipment.transport_id
WHERE shipment.id = 31
```

Join 2: description:
```
SELECT
    client.fullname AS client_name,
    client.email AS client_mail,
    client.contact_number AS client_number,
    COUNT(item_copy.id) AS items_ordered
FROM client
INNER JOIN item_copy ON item_copy.client_id = client.id
GROUP BY client.id, client.fullname, client.email, client.contact_number;
```

Join 3: description:
```
code
```

## Triggers

Trigger 1: description:
```
DELIMITER $$

CREATE TRIGGER trg_shipment_arrived
AFTER UPDATE ON transport_log
FOR EACH ROW
BEGIN
    IF NEW.check_in_time IS NOT NULL 
       AND OLD.check_in_time IS NULL THEN
       
       UPDATE shipment
       SET arrival_datetime = NEW.check_in_time,
           clearance_state = 'arrived'
       WHERE shipment.id = NEW.shipment_id
         AND shipment.expected_location_id = NEW.checkpoint_location_id;
    END IF;
END$$

DELIMITER ;
```


Trigger 2: shipment expected date past curret date make entry into trigger that seas "past due date"
```
DELIMITER $$
CREATE TRIGGER past_due_date
AFTER INSERT ON shipment
FOR EACH ROW
BEGIN

    IF NEW.expected_date < CURDATE() THEN
        INSERT INTO delays (reason, delay_log_time, new_expected_date, transport_id)
        VALUES ('Past due date', NOW(), NULL, NEW.transport_id);
    END IF;
END$$

DELIMITER ;
```

Trigger 3: description:
```
code
```


## Stored Procedures

Stored Procedure 1: calculete the weight of each shipment
```
DELIMITER $$

CREATE PROCEDURE GetShipmentWeight(IN shipmentId INT)
BEGIN
    DECLARE totalWeight DECIMAL(10,2);

    SELECT 
        SUM(CAST(REPLACE(i.weight, 'kg', '') AS DECIMAL(10))) 
    INTO totalWeight
    FROM item_copy ic
    INNER JOIN item i ON ic.original_item_id = i.id
    WHERE ic.shipment_id = shipmentId;

    SELECT shipmentId AS Shipment_ID, 
           IFNULL(totalWeight, 0) AS Total_Weight_KG;
END$$

DELIMITER ;

```
Call Stored Procedure 1:
```

CALL GetShipmentWeight(30);

```

Stored Procedure 2: description:
```
code
```

Stored Procedure 3: description:
```
code
```

## Demo video

## Figma board link
```
https://www.figma.com/design/cLWp2MrnSBzezJTineytGl/Untitled?node-id=1-2&t=LfH7NwC5GOeJoSlk-1
```
