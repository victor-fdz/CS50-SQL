
-- *** The Lost Letter ***

-- STEP 1
-- Searched: Packages sent from Annekes' home, restricted to things related to letters.
SELECT * FROM "packages" WHERE  "from_address_id" = (
    SELECT "id" FROM "addresses" 
        WHERE "address" = '900 Somerville Avenue' AND "contents" LIKE "%letter%"
    );
-- Obtained: There's a 'Congratulatory letter' sent to "to_addess_id" 854 and with a package_id of 384.

-- STEP 2
-- Searched: Which is the address associated with this address ID.
SELECT * FROM "addresses" WHERE "id" = '854';
-- Obtained: The correct address was "2 Finnigan Street". There was a typo. It's a residential zone.



-- *** The Devious Delivery ***

-- STEP 1
-- Searched: Packages without "from" address.
SELECT * FROM "packages" WHERE "from_address_id" IS NULL;
-- Obtained: The content of the package is a Duck debugger and the package ID is 5098. It was originally sent to address ID 50?.

-- Searched: Was it really sent to address ID 50?
SELECT * FROM "scans"  WHERE "package_id" = 5098;
-- Obtained: The package was picked from ID 50 and resent to address ID 348.

-- STEP 3
-- Searched: What is this address?
SELECT * FROM "addresses" WHERE "id" = 348
-- Obteined: It's a Police Station. 

-- Comment: My deduction is that the associate received the rubber duck and sent it to the police + the "drop" entry in "scans" was not tracked.



-- *** The Forgotten Gift ***
-- STEP 1
-- Searched: Which are the IDs of the origin and destiny places?
SELECT "id", "address" FROM "addresses" WHERE "address" = '109 Tileston Street' OR "address" = '728 Maple Place';
-- Obtained: Tileston = 9873 and Maple 4983.


-- STEP 2
-- Searched: What was the package content? Which is the package ID?
SELECT "id", "contents" FROM "packages" WHERE "from_address_id" = '9873' AND "to_address_id" = '4983';
-- Obtained: The package contained Flowers. The package ID is 9523.

-- STEP 3: 
-- Searched: Was the package succesfully delivered?
 SELECT * FROM "scans" WHERE "package_id" = '9523';
-- Obtained: The package was correctly picked and dropped in the specified directions, but re-picked by a different driver (ID 17) a week after.

-- STEP 4:
-- Searched: Who was that driver?
SELECT "name" FROM "drivers" WHERE "id" = 17;
-- Obtained: His name was Mikel.

-- Comment: My deduction is that the gift was outside the granddaughter's mailbox and after 7 days of not picking it, another driver took it away.
