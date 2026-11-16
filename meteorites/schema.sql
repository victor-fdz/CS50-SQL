CREATE TABLE IF NOT EXISTS "meteorites_temp" (
    "name",
    "id",
    "nametype",
    "class",
    "mass",
    "discovery",
    "year",
    "lat",
    "long"
);

CREATE TABLE  IF NOT EXISTS "meteorites" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "class" TEXT NOT NULL,
    "mass" FLOAT,
    "discovery" TEXT NOT NULL,
    "year" INTEGER,
    "lat" FLOAT,
    "long" FLOAT,
    PRIMARY KEY("id")
);
