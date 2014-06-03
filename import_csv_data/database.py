import sqlite3
import logging
from time import sleep
import sys
from py2neo import neo4j, rel
from io import StringIO


logging.basicConfig(level=logging.INFO)

class neo4j_db(object):
    """Connect to neo4j database"""
    def __init__(self, dbpath):
        self.dbpath = dbpath

    def _db_init(self):
        logging.debug("Trying to connect to db.")
        try:
            self.db = neo4j.GraphDatabaseService(self.dbpath)
            self.write_batch = neo4j.WriteBatch(self.db)
            return True
        except Exception as e:
            logging.debug("db_init: %s" % e)
            return False

    def connect(self):
        i = 0
        while True:
            a = self._db_init()
            if a:
                break
            if i == 5:
                logging.error("db_connect: DB connection failed.")
                sys.exit(1)
            i += 1
            sleep(3)