CREATE TABLE IF NOT EXISTS "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "schools_unis" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT  NOT NULL CHECK("type" IN ('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'Technical School', 'Research Centre', 'Institute', 'Academy', 'Other')),
    "location" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "industry" TEXT  NOT NULL CHECK("industry" IN ('Education', 'Technology', 'Finance', 'Transport', 'Sports', 'Consultory', 'Law', 'Biotechnology', 'Health', 'Animals', 'Nature', 'Other')),
    "location" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "connections_user" (
    "id" INTEGER,
    "user1_id" INTEGER NOT NULL CHECK("user1_id" < "user2_id"),
    "user2_id" INTEGER NOT NULL,
    UNIQUE("user1_id", "user2_id"),
    PRIMARY KEY ("id"),
    FOREIGN KEY("user1_id") REFERENCES "users"("id"),
    FOREIGN KEY("user2_id") REFERENCES "users"("id")
);

CREATE TABLE IF NOT EXISTS "connections_school" (
    "id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "school_id" INTEGER NOT NULL,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC,
    "degree" TEXT NOT NULL CHECK("degree" IN ('HS', 'BA', 'MA', 'PhD', 'Diploma', 'Course', 'Other')),
    PRIMARY KEY ("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools_unis"("id")
);

CREATE TABLE IF NOT EXISTS "connections_company" (
    "id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC,
    "title" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
)
