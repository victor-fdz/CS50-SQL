-- Which is the japanese name of Hiroshige's paint with less entrioy?
SELECT "japanese_title" AS 'Name (JAP)' FROM "views" WHERE "artist" = 'Hiroshige' ORDER BY "entropy" LIMIT 1;
