print("Try | Hacked!")

from cs50 import SQL

db = SQL("sqlite:///dont-panic.db") # Connect to the db

password = input("Enter a password: ") # Selected the new hacked psw

# Change the password
db.execute(
    """
    UPDATE "users"
    SET "password" = ?
    WHERE "username" = 'admin';
    """,
    password
)
