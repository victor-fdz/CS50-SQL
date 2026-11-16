SELECT "city", COUNT("city") AS "Number of Public Schools" FROM "schools" WHERE "type" = 'Public School' GROUP BY "city" HAVING COUNT("city") < 4 ORDER BY "Number of Public Schools" DESC, "city";
