import io

import psycopg2


class Database:

    def __init__(self, host, port, user, database, password):
        """ Open connection """

        self.conn = psycopg2.connect(
            host=host,
            database=database,
            user=user,
            password=password,
            port=port
        )

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
