-- Which was the height of the tallest left-handed (both bat and throw) player that made his debut in 2017? 

SELECT "height" AS "Higher Height in 2017 Left-Handed Rookies" FROM "players" WHERE ("bats" = 'L' AND "throws" = 'L') AND ("debut" BETWEEN '2017-01-01' AND '2017-12-31') ORDER BY "height" DESC LIMIT 1;
