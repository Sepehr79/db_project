import unittest

from src.database import Database


class MyTestCase(unittest.TestCase):

    def testOpenConnection(self):
        """ Test connection to my database and execute query """

        # Open connection (host, port, user, database, password)
        database = Database("localhost", 5432, "postgres", "db_project", "s134s134")

        # Execute database schema from sql file
        file = open("../database/sql/create_schema.sql", "r")
        database.create_schema(file)
        file.close()

        # Execute sample query
        database.select_query(""" select * from "Patient"; """)

        # Close connection
        database.close_connection()

    def testExecuteSelectQueries(self):

        file = open("../database/sql/select_queries.sql", "r")
        sqls = file.read().split("\n")
        file.close()

        self.assertIsNotNone(sqls)
        self.assertEqual(sqls[0], """set search_path to db_project;""")





if __name__ == '__main__':
    unittest.main()
