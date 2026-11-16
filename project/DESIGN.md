# Design Document

By Víctor Fernández Oliveras

Video overview: <https://www.youtube.com/watch?v=59cb3RU1twU>

## Scope

The scope of this database is to store information of all the catalan volleyball clubs and their players, as well as new players that want to join a voleyball club.
The objective would be to make the "finding new club" or "finding new players" (team planning) easier in this specific environment.
It would serve as an informative resource.
It would not act as a social media app (not a "volleyball Linkedin" or "volleyball tinder").
The players would find information of the available clubs and their interests in new players.
The clubs will find information about available players and their very basic characteristics.
The clubs should generate their entries before the players do, for integrity.

## Functional Requirements

There are 2 types of users for this database:
- Players: they can generate their profile (this would require further development, obviously) and register in the club they play.
- Clubs: they can genegrate their profiles (same) and register their vaccancies (players/positions they are searching).
None of them should be able of editing others' information. I

## Representation

### Entities

Entities are captured in SQLite tables with the following schema.

#### players

The `players` table includes:

- `id`, which specifies the unique ID for the player as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `name`, which specifies the player's first name as `TEXT`. The `NOT NULL` constraint ensures this field cannot be empty.
- `surname`, which specifies the player's primary surname as `TEXT`. The `NOT NULL` constraint is applied.
- `surname2`, which specifies the player's secondary surname as `TEXT` to account for both paternal and maternal surnames. The `NOT NULL` constraint is applied.
- `team_id`, which specifies the ID of the club team the player belongs to as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `clubs-teams` table and allows `NULL` values for unattached players.
- `gender`, which specifies the player's gender as `TEXT`. A `CHECK` constraint restricts values to 'Male', 'Female', or 'Others'.
- `age`, which specifies the player's age as an `INTEGER`. The `NOT NULL` constraint is applied.
- `height`, which specifies the player's height as an `INTEGER`. The `NOT NULL` constraint is applied.
- `mail`, which specifies the player's email address as `TEXT`. A `UNIQUE` constraint ensures no two players share the same email.
- `telephone`, which specifies the player's phone number as an `INTEGER`. This field is optional (`NULL` allowed).
- `password`, which specifies the player's account password as `TEXT`. The `NOT NULL` constraint is applied.

#### clubs

The `clubs` table includes:

- `id`, which specifies the unique ID for the club as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `name`, which specifies the club's name as `TEXT`. The `NOT NULL` constraint is applied.
- `region`, which specifies the geographical Catalan region of the club as `TEXT`. A `CHECK` constraint restricts values to 'Barcelona', 'Tarragona', 'Lleida', or 'Girona'.
- `city`, which specifies the city of the club as `TEXT`. A `CHECK` constraint restricts values to specific Catalan cities.
- `year_created`, which specifies the foundation year of the club as an `INTEGER`. The `NOT NULL` constraint is applied.
- `mail`, which specifies the club's contact email as `TEXT`. A `UNIQUE` constraint ensures no two clubs share the same email.
- `telephone`, which specifies the club's phone number as an `INTEGER`. This field is optional.
- `password`, which specifies the club's account password as `TEXT`. The `NOT NULL` constraint is applied.

#### players-positions

The `players-positions` table includes:

- `id`, which specifies the unique ID for the player-position relation as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `player_id`, which specifies the player's ID as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `players` table and has a `NOT NULL` constraint.
- `position`, which specifies the volleyball position as `TEXT`. A `CHECK` constraint restricts values to standard positions like 'Middle Blocker', 'Outside Hitter', 'Setter', 'Opposite', 'Libero', or 'Support Server'.
- `frequence`, which specifies the proficiency or frequency of playing that position as `TEXT`. A `CHECK` constraint restricts values to 'Primary Position', 'Secondary Position', or 'If necessary, I can play there'.

#### clubs-teams

The `clubs-teams` table includes:

- `id`, which specifies the unique ID for the team as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `club_id`, which specifies the parent club's ID as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `clubs` table and has a `NOT NULL` constraint.
- `gender`, which specifies the team's gender category as `TEXT`. A `CHECK` constraint restricts values to 'Male', 'Female', or 'Mixt'.
- `category`, which specifies the age category of the team as `TEXT`. A `CHECK` constraint restricts values to categories ranging from 'Prebenjamin' to 'Senior' and 'Adults'.
- `division`, which specifies the competitive division of the team as `TEXT`. A `CHECK` constraint restricts values to Catalan divisions ('Primera', 'Segona', or 'Tercera Divisió Catalana').

#### teams-positions-searched

The `teams-positions-searched` table includes:

- `id`, which specifies the unique ID for the search requirement as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `team_id`, which specifies the team looking for players as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `clubs-teams` table and has a `NOT NULL` constraint.
- `position_searched`, which specifies the position the team is recruiting for as `TEXT`. A `CHECK` constraint restricts values to valid volleyball positions.

#### players-clubs-played

The `players-clubs-played` table includes:

- `id`, which specifies the unique ID for the historical record as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
- `club_id`, which specifies the club ID where the player played as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `clubs` table.
- `player_id`, which specifies the player's ID as an `INTEGER`. This acts as a foreign key referencing the `id` column in the `players` table.
- `season`, which specifies the active season as `TEXT`. A `CHECK` constraint restricts values to recent seasons like '2025-2026', '2024-2025', '2023-2024', or '2022-2023'.

### Relationships

![ER Diagram](diagram.png)

* One club can have 0 to many teams. 0, if they have yet to create the entries for their teams. Each team is a real team within the defined club.
* One team can have 0 to many players. 0 at the begginig and more and more when players start creating their entries to the database.
* One team can search 0 to 7 positions. 0 if they still have to publish their vacancies (or they do not accept new players). 7 if they search all the types of players.
* Each player can only be in 1 team and each team can only be in 1 club.
* Each player is associated to 7 to many positions, depending on their charactersitics.

## Optimizations

Views were defined because of the high traffic of users searching for setters and girls:
-`setters_3`: In the third catalan division, setters are very demanded by most of the teams.
-`fem`: Femenine volleyball is more frequent (more teams, more divisions).

And the defined indexes include columns that will be very used in searches (both for searching an specific player/club and for filtering):
- `players_by_age`
- `clubs_by_region`
- `clubs_by_name`
- `players_by_name`

## Limitations

* Right now is an scaffold: it still requires a complete list of city names, seasons... (and more example data to play in).
* This database would necessary go with an app/web from where players and clubs could register and perform searches in a more user-friendly way.
