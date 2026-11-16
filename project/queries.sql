-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database


-- Typical commands to add information to each table of the database.
INSERT INTO "clubs" ("name", "region", "city", "year_created", "mail", "telephone", "password")
    VALUES ('Club Voleibol Sant Esteve de Palautordera', 'Barcelona', 'Sant Esteve de Palautordera', '2025', 'cvsep@gmail.com', '695970649', 'voleistesteve123');

INSERT INTO "clubs-teams" ("club_id", "gender", "category", "division")
    VALUES ('1', 'Male', 'Senior', 'Tercera Divisió Catalana');

INSERT INTO "players" ("name", "surname", "surname2", "team_id", "age", "height", "gender", "mail", "telephone", "password")
    VALUES ('Leon', 'Nikolov', 'Nishida', '1', '22', '187', 'Male', 'leoNNN@gmail.com', '696970650', 'ilovevoleyball789');

INSERT INTO "players-positions" ("player_id", "position", "frequence")
    VALUES ('1', 'Outside Hitter', 'Primary Position'), ('1', 'Setter', 'Secondary Position');

INSERT INTO "teams-positions-searched" ("team_id", "position_searched")
    VALUES ('1', 'Opposite');

INSERT INTO "players-clubs-played" ("club_id", "player_id", "season")
    VALUES ('1', '1', '2025-2026');


-- [FOR THE CLUBS] Query to search for female sub-16 Liberos that play in 2nd Division in Lleida-based clubs.
SELECT
    CONCAT("players"."name", ' ', "surname",' ', "surname2") AS 'Name',
    "players"."gender" AS 'Gender',
    "age" AS 'Age',
    "height" AS 'Height',
    CONCAT("players"."mail", ' / ',"players"."telephone") AS 'Contact',
    "clubs"."name" AS 'Current club',
    CONCAT("position", ' (', "frequence", ')') AS 'Libero Frequence'
    FROM "players"
        JOIN "players-positions" ON "players-positions"."player_id" = "players"."id"
        JOIN "clubs-teams" ON "clubs-teams"."id" = "players"."team_id"
        JOIN "clubs" ON "clubs"."id" = "clubs-teams"."club_id"
        WHERE "position" = 'Libero' AND "division" = 'Segona Divisió Catalana' AND "players"."gender" = 'Female' AND "age" < '17' AND "clubs"."region" = 'Lleida';

-- [FOR THE PLAYERS] Query to search male senior 3rd division teams that are searching male opposite in Barcelona.
SELECT
    "name" AS 'Name',
    CONCAT("region", ' (', "city", ')') AS 'Location',
    "year_created" AS 'Year of Foundationn',
    CONCAT("clubs"."mail", ' / ',"clubs"."telephone") AS 'Contact'
        FROM "clubs"
            JOIN "clubs-teams" ON "clubs-teams"."club_id" = "clubs"."id"
            JOIN "teams-positions-searched" ON "teams-positions-searched"."team_id" = "clubs-teams"."id"
            WHERE "position_searched" = 'Opposite' AND "division" = 'Tercera Divisió Catalana' AND "clubs-teams"."gender" = 'Male' AND "clubs"."region" = 'Barcelona';
