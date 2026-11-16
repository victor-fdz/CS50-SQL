SELECT "id" FROM "users"
    WHERE "id" IN (
        SELECT "to_user_id" FROM (
            SELECT "from_user_id", "to_user_id", COUNT("to_user_id") AS "n_messages" FROM "messages"
            WHERE "from_user_id" = (
                SELECT "id" FROM "users"
                    WHERE "username" = 'creativewisdom377'
                )
            GROUP BY "to_user_id"
            ORDER BY "n_messages" DESC
            LIMIT 3
            )
        )
;
