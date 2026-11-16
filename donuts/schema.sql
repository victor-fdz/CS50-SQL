CREATE TABLE IF NOT EXISTS "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price_per_unit" REAL NOT NULL,
    "unit" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT NOT NULL CHECK ("gluten_free" IN ("yes", "no")),
    "price" REAL NOT NULL,
    "available" BOOLEAN NOT NULL CHECK ("available" IN ("yes", "no")),
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "donuts_ingredients" (
    "id" INTEGER,
    "donut_id" INTEGER NOT NULL,
    "ingredient_id" INTEGER NOT NULL,
    UNIQUE ("donut_id", "ingredient_id"),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE IF NOT EXISTS "orders" (
    "id" INTEGER,
    "number" INTEGER NOT NULL UNIQUE CHECK("number" > 0),
    "customer_id" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE IF NOT EXISTS "orders_donuts" (
    "id" INTEGER,
    "order_id" INTEGER NOT NULL,
    "donut_id" INTEGER NOT NULL,
    "number_donuts" INTEGER NOT NULL CHECK("number_donuts" > 0),
    UNIQUE ("order_id", "donut_id"),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE IF NOT EXISTS "customers"  (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY ("id")
);
