-- Each player should generate his/her profile. The objective is that their information remains stored in the database and they are the only ones who can modify it.
CREATE TABLE IF NOT EXISTS "players" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "surname2" TEXT NOT NULL, -- In Spain, people usually identify themselves with both the dad's and mom's surnames.
    "team_id" INTEGER, -- Accepts nulls for those players without a team. The app should offer an easy-to-see list of the ids for each club team.
    "gender" TEXT NOT NULL CHECK ("gender" IN ('Male', 'Female', 'Others')),
    "age" INTEGER NOT NULL, -- Not the category directly, because a e. g. a 17 y/o player can play in a Senior team.
    "height" INTEGER NOT NULL, -- Probably the most important physical feature in a volleyball athelete. Worth to know for a club searching players.
    "mail" TEXT NOT NULL UNIQUE, -- Mandatory to contact the player. This app would work more like a database than as a "voleyball tinder"
    "telephone" INTEGER, -- Not mandatory because might be too personal.
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY("team_id") REFERENCES "clubs-teams"("id")
);

-- Clubs would have their own accounts, with the same justification as for players.
CREATE TABLE IF NOT EXISTS "clubs" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "region" TEXT NOT NULL CHECK ("region" IN ('Barcelona', 'Tarragona', 'Lleida', 'Girona')), -- The 4 catalan regions. Important for travel times.
    "city" TEXT NOT NULL CHECK ("city" IN ('Barcelona', 'Mataró', 'Vilassar de Mar', 'Sant Esteve de Palautordera')), --  This should include all the catalan cities, obviosuly.
    "year_created" INTEGER NOT NULL, -- Could be an interesting data for players to select or discard clubs.
    "mail" TEXT NOT NULL UNIQUE,
    "telephone" INTEGER,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

-- In which positions can the player play? Relevant information for the players to describe themselves and for the clubs to select the players they are interested in.
CREATE TABLE IF NOT EXISTS "players-positions" (
    "id" INTEGER,
    "player_id" INTEGER NOT NULL,
    "position" TEXT NOT NULL CHECK ("position" IN ('Middle Blocker', 'Outside Hitter', 'Setter', 'Opposite', 'Libero', 'Support Server', 'Have not played')), -- Subpositions not considered here as they should be object of further conversation between the club and the player.
    "frequence" TEXT NOT NULL CHECK ("frequence" IN ('Primary Position', 'Secondary Position', 'If necessary, I can play there')),  -- Provisional ways to say it, but these are the ideas.
    PRIMARY KEY ("id"),
    FOREIGN KEY("player_id") REFERENCES "players"("id")
);

-- Which teams do the clubs have? Important so players can know if there is a team for their age.
CREATE TABLE IF NOT EXISTS "clubs-teams" (
    "id" INTEGER,
    "club_id" INTEGER NOT NULL,
    "gender" TEXT NOT NULL CHECK ("gender" IN ('Male', 'Female', 'Mixt')),
    "category" TEXT NOT NULL CHECK ("category" IN ('Prebenjamin', 'Benjamin', 'Alevin', 'Infantile', 'Cadet', 'Juvenile', 'Junior', 'Senior', 'Adults')),
    "division" TEXT NOT NULL CHECK ("division" IN ('Primera Divisió Catalana', 'Segona Divisió Catalana', 'Tercera Divisió Catalana')),
    PRIMARY KEY ("id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("id")
);

-- Which types of players do each of the teams search? Crucial for a great player-club match.
CREATE TABLE IF NOT EXISTS "teams-positions-searched" (
    "id" INTEGER,
    "team_id" INTEGER NOT NULL,
    "position_searched" TEXT NOT NULL CHECK ("position_searched" IN ('Middle Blocker', 'Outside Hitter', 'Setter', 'Opposite', 'Libero', 'Support Server')),
    PRIMARY KEY ("id"),
    FOREIGN KEY("team_id") REFERENCES "clubs-teams"("id")
);

-- In which teams has each player played? Crucial feature for clubs to know a little bit of the players' profile.
CREATE TABLE IF NOT EXISTS "players-clubs-played" (
    "id" INTEGER,
    "club_id" INTEGER NOT NULL,
    "player_id" INTEGER NOT NULL,
    "season" TEXT NOT NULL CHECK ("season" IN ("2025-2026", "2024-2025", "2023-2024", "2022-2023")),
    PRIMARY KEY ("id"),
    FOREIGN KEY("player_id") REFERENCES "players"("id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("id")
);

-- Example of view (this could be repeated for every position and division).
-- In the third catalan division, setters are very demanded.
CREATE VIEW "setters_3" AS
SELECT
    CONCAT("players"."name", ' ', "surname",' ', "surname2") AS 'Name',
    "players"."gender" AS 'Gender',
    "age" AS 'Age',
    "height" AS 'Height',
    CONCAT("players"."mail", ' / ',"players"."telephone") AS 'Contact',
    "clubs"."name" AS 'Current club',
    "division" AS 'Current Division',
    CONCAT("position", ' (', "frequence", ')') AS 'Setting Frequence'
    FROM "players"
        JOIN "players-positions" ON "players-positions"."player_id" = "players"."id"
        JOIN "clubs-teams" ON "clubs-teams"."id" = "players"."team_id"
        JOIN "clubs" ON "clubs"."id" = "clubs-teams"."club_id"
        WHERE "position" = 'Setter' AND "division" = 'Tercera Divisió Catalana';

-- Femenine volleyball is more frequent (more teams, more divisions).
CREATE VIEW "fem" AS
SELECT
    CONCAT("players"."name", ' ', "surname",' ', "surname2") AS 'Name',
    "players"."gender" AS 'Gender',
    "age" AS 'Age',
    "height" AS 'Height',
    CONCAT("players"."mail", ' / ',"players"."telephone") AS 'Contact',
    "clubs"."name" AS 'Current club',
    "division" AS 'Current Division',
    "position" AS 'Position'
    FROM "players"
        JOIN "players-positions" ON "players-positions"."player_id" = "players"."id"
        JOIN "clubs-teams" ON "clubs-teams"."id" = "players"."team_id"
        JOIN "clubs" ON "clubs"."id" = "clubs-teams"."club_id"
        WHERE "frequence" = 'Primary Position' AND "players"."gender" = 'Female';


-- Useful indexes
-- Index players by age, as it is a typical filter when searching players.
CREATE INDEX "players_by_age" ON "players"("age");
-- Index clubs by region, as it is a crucial feature for players to decide where to play.
CREATE INDEX "clubs_by_region" ON "clubs"("region");
-- Club and Player names
CREATE INDEX "clubs_by_name" ON "clubs"("name");
CREATE INDEX "players_by_name" ON "clubs"("surname");

