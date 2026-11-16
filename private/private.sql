CREATE TABLE IF NOT EXISTS "cipher" (
    "Sentence Number" INTEGER NOT NULL,
    "Character Number" INTEGER NOT NULL,
    "Message Length" INTEGER NOT NULL
);

INSERT INTO "cipher"
("Sentence Number", "Character Number", "Message Length")
VALUES
(14, 98, 4), (114, 3, 5), (618, 72, 9), (630,7,3), (932, 12, 5), (2230, 50, 7), (2346, 44, 10), (3041, 14, 5);

CREATE VIEW "message" AS SELECT substr("sentence", "Character Number", "Message Length") AS "phrase" FROM "cipher" JOIN "sentences" ON "cipher"."Sentence Number" = "sentences"."id";
