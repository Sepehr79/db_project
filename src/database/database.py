import io

import psycopg2


class Database:

    def __init__(self, properties):
        """ Open connection """

        if isinstance(properties, dict):

            self.conn = psycopg2.connect(
                host=properties["host"],
                database=properties["database_name"],
                user=properties["database_user"],
                password=properties["database_password"],
                port=int(properties["port"])
            )
        else:
            raise AttributeError("Please pass a dict type to the database constructor")

    def close_connection(self):
        self.conn.close()

    def create_schema(self, file):
        """ Create new schema from sql file """

        if isinstance(file, io.IOBase):
            # Read SQL from file
            sql = file.read()
            # Execute sql to create schema and tables
            cur = self.conn.cursor()
            cur.execute(sql)
            self.conn.commit()

            cur.close()
        else:
            raise AttributeError(" Input must be file ")

    def select_query(self, query):
        """ Execute select queries and display result """

        if isinstance(query, str):
            cur = self.conn.cursor()

            cur.execute(query)

            for result in cur.fetchall():
                print(result)

            cur.close()
        else:
            raise AttributeError(" Input must be str ")

    def execute_query(self, query):
        """ Execute any sql query in database """
        if isinstance(query, str):
            cur = self.conn.cursor()

            cur.execute(query)
            self.conn.commit()

            cur.close()
