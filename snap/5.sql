WITH
    "lovely_frieNds" AS (
        SELECT "friend_id" FROM "friends"
            WHERE "user_id" = (
                SELECT "id" FROM "users"
                    WHERE "username" = 'lovelytrust487'
                )
        ),
    "exceptional_friends" AS (
        SELECT "friend_id" FROM "friends"
            WHERE "user_id" = (
                SELECT "id" FROM "users"
                    WHERE "username" = 'exceptionalinspiration482'
                )
        )
SELECT "exceptional_friends"."friend_id" AS "mutuals" FROM "lovely_friends"
    JOIN "exceptional_friends" ON "exceptional_friends"."friend_id" = "lovely_friends"."friend_id";
