CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id", "property_type", "host_name", "reviews"
    FROM "listings"
    JOIN (
        SELECT "listing_id", COUNT ("reviewer_name") AS "reviews"
        FROM "reviews" GROUP BY "listing_id"
        ) AS "reviews_count"
    ON "listings"."id" = "reviews_count"."listing_id"
ORDER BY "reviews" DESC, "property_type", "host_name"
LIMIT 100
;
