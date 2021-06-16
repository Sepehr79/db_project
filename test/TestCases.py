import unittest

from src.database import Database


class MyTestCase(unittest.TestCase):

    @staticmethod
    def testOpenConnection():
        """ Test connection to my database and execute query """

        # Open connection
        # host, port, user, database, password
        database = Database("localhost", 5432, "postgres", "db_project", "s134s134")

        # Execute database schema from sql file
        file = open("../database/sql/create_schema.sql", "r")
        database.create_schema(file)
        file.close()

        # Execute sample query
        database.select_query(""" select * from "Patient"; """)

        # Close connection
        database.close_connection()


if __name__ == '__main__':
    unittest.main()
