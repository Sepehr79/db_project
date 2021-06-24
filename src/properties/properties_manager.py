import io


def getProperties(file):
    """ Returns a map of properties from properties file """
    if isinstance(file, io.IOBase):
        properties = {}

        with file as f:
            for line in f:
                if "=" in line:
                    name, value = line.split("=", 1)
                    properties[name.strip()] = value.strip()
            f.close()

        return properties


def getSqls(file):
    """ Read sql queries from sql file """
    if isinstance(file, io.IOBase):
        sqls = file.read().split("\n")
        file.close()
        return sqls
