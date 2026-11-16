CREATE VIEW "available" AS
SELECT "listings"."id", "property_type", "host_name", "availabilities"."date"
    FROM "availabilities"
    JOIN "listings"
        ON "availabilities"."listing_id" = "listings"."id"
    WHERE "available" = 'TRUE'
;
