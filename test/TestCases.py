import unittest

from src.database.database import Database
from src.properties import properties_manager


class MyTestCase(unittest.TestCase):

    def testReadPropertiesFile(self):
        """ Test reading properties file """

        properties = properties_manager.getProperties(open("../database.properties", "r"))

        self.assertEqual(properties["host"], "localhost")
        self.assertEqual(int(properties["port"]), 5432)
        self.assertEqual(properties["database_user"], "postgres")

    def testOpenConnection(self):
        """ Test connection to my database and execute query """

        # Read database properties from database.properties file
        properties = properties_manager.getProperties(open("../database.properties", "r"))

        # Open connection with database properties
        database = Database(properties)

        # Execute database schema from sql file
        file = open("../database/sql/create_schema.sql", "r")
        database.create_schema(file)
        file.close()

        # Execute sample query
        database.select_query(""" select * from "Patient"; """)

        # Close connection
        database.close_connection()

    def testReadSelectQueries(self):
        """ Test read select queries from sql file """
        sqls = properties_manager.getSqls(open("../database/sql/select_queries.sql", "r"))
        self.assertIsNotNone(sqls)
        self.assertEqual(sqls[0], """set search_path to db_project;""")


if __name__ == '__main__':
    unittest.main()
