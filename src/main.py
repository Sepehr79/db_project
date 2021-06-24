from src.database.database import Database
from src.properties import properties_manager


def show_console(database, query):
    """ Show input console to the user """
    if isinstance(database, Database) and isinstance(query, list):
        num = 1
        while num != 0:
            try:
                num = int(input("Enter query number to execute. 0 for exit: "))
                if 1 <= num <= 30:
                    database.select_query(query[num])
            except ValueError:
                print("Wrong input!")


def main():
    """ Main method """

    # Read sql queries
    sqls = properties_manager.getSqls(open("../database/sql/select_queries.sql", "r"))

    # Read database properties
    properties = properties_manager.getProperties(open("../database.properties", "r"))

    # Open database connection
    database = Database(properties)

    # Execute database schema
    database.create_schema(open("../database/sql/create_schema.sql", "r"))

    # Set current schema ('set search_path to db_project;')
    database.execute_query(sqls[0])

    show_console(database, sqls)

    # Close database connection
    database.close_connection()


if __name__ == "__main__":
    main()
