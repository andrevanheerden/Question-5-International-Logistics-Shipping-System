

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
code
```

Join 2: description:
```
code
```

Join 3: description:
```
code
```

## Triggers

Trigger 1: description:
```
code
```

Trigger 2: description:
```
code
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
