CREATE VIEW "june_vacancies" AS
SELECT "listings"."id", "property_type", "host_name", "days_vacant"
    FROM "listings"
    JOIN (
        SELECT "listing_id", COUNT("date") AS "days_vacant"
            FROM "availabilities"
            WHERE "available" = 'TRUE' AND "date" LIKE '2023-06-%'
            GROUP BY "listing_id"
        ) AS "listing_june"
        ON "listing_june"."listing_id" = "listings"."id"
    LIMIT 5
;
