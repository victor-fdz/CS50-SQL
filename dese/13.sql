SELECT "type" FROM "staff_evaluations" JOIN "districts" ON "districts"."id" = "staff_evaluations"."district_id" WHERE "unsatisfactory" = (SELECT MAX("unsatisfactory") FROM "staff_evaluations");
