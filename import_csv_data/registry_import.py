import csv
from py2neo import neo4j, rel
import sys
from time import sleep
from database import neo4j_db as database
import logging
import re

logging.basicConfig(level=logging.DEBUG)

class uploader():
    """
    Function for uploading crawl data into Neo4j
    """
    def __init__(self, dbpath, report_date):
        self.report_date = report_date
        self.batch_limit = 5000

        self.db = database(dbpath)
        self.db.connect()
        logging.debug("init: database connection completed")

        self.write_batch = self.db.write_batch

        self.db = database(dbpath)
        self.db.connect()
        logging.debug("init: database connection completed")

    def batch_common(self, batch):
        if len(batch) == self.batch_limit:
            try:
                batch.submit()
            except:
                sleep(1)
                self.db.connect()
                sleep(1)
                batch.submit()
            logging.debug("batch_common: flushing batch")
            batch.clear()
        return

    def batch_flush(self, batch):
        output = batch.submit()
        batch.clear()
        logging.debug("batch_flush: flushing batch")
        return output

    def batch_add(self, data_type, batch, index, key, value, item):
        '''Create a new node in index'''
        batch.get_or_create_in_index(data_type, index, key, value, item)
        return self.batch_common(batch)

    def batch_cypher(self, batch, request):
        batch.append_cypher(request)
        return self.batch_common(batch)

    def add_site(self, line):
        '''Insert new record into db'''

        self.batch_cypher(self.write_batch, ('MERGE  (faculty:Faculty { name: "%s"}) MERGE (contact:Person {name:"%s"}) MERGE (maintain:Person {name:"%s"}) MERGE (department:Department {name: "%s"}) CREATE (faculty)-[:Owns]->(site:Website {\
            url: "%s", protocol: "%s", title: "%s"})' % (line["faculty"],line["primary_contact"],line["maintainer"], line["department"], line["url"], line["protocol"], line["title"])))

        self.batch_cypher(self.write_batch, ('MERGE (site:Website { url: "%s"}) MERGE (contact:Person{name:"%s"}) MERGE (maintainer:Person{name:"%s"}) CREATE (contact)<-[:Contact]-(site)-[:Maintainer]->(maintainer)' % (line["url"],line["primary_contact"],line["maintainer"])))

    def add_index(self, value):
        '''Create index'''
        self.batch_cypher(self.write_batch, ('CREATE INDEX ON :Person(%s)' % (value)))
        self.batch_flush(self.write_batch)


if __name__ == '__main__':

    dbpath = 'http://localhost:7474/db/data'
    report_date = '2014-05-22'
    loader = uploader(dbpath, report_date)

    def feed_data():
        the_list = {}
        temp = []
        with open('data.csv', newline='', encoding="ISO-8859-1") as csvfile:
            data = csv.reader(csvfile)
            try:
                for row in data:
                    print(row[0])
                    tmp = row[0].split('://')
                    print(tmp)
                    if not len(row[5]):
                        row[5] = "Unknown"
                    if "#Unknown" in row[4]:
                        row[4] = "Unknown"
                    if "#Unknown" in row[3]:
                        row[4] = "Unknown"
                    if not len(row[6]):
                        row[6] = "Unknown"

                    the_list[tmp[1]] = {"url": tmp[1], "protocol": tmp[0], "title": row[1],
                    "status": row[2], "faculty": row[3], "department": row[4], "primary_contact": row[5],
                    "maintainer": row[6]}

            except UnicodeDecodeError as err:
                print("UnicodeDecodeError {0}".format(err)) 
                sys.exit(1)
        add_sites(the_list)
        # add_people(the_list)
        # add_relationship(the_list)
        # add_departments()

    
    def add_sites(the_list):
        for site in the_list:
            loader.add_site(the_list[site])
        loader.batch_flush(loader.write_batch)


    feed_data()


