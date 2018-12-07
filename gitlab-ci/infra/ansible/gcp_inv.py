#!/usr/bin/env python3
import subprocess
import json
import sqlite3
import argparse

host = ''

gcp_instances = """ CREATE TABLE IF NOT EXISTS gcp_instances (
     id integer PRIMARY KEY,
     name text NOT NULL,
     ext_ip text NOT NULL,
     int_ip text NOT NULL,
     tags text NOT NULL  );
"""

def create_connection(db_file):
    try:
        connection = sqlite3.connect(db_file)
        return connection
    except Error as e:
        print(e)
    return None

def create_table(connection, create_table_sql):
    try:
        c = connection.cursor()
        c.execute(create_table_sql)
    except Error as e:
        print(e)

def sql_query(connection, sql):
    try:
        c = connection.cursor()
        c.execute(sql)
        return c
    except Error as e:
        print(e)

parser = argparse.ArgumentParser()
parser.add_argument('--host', dest="host")
parser.add_argument('--list', action='store_true')
try:
    results = parser.parse_args()
except:
    parser.print_help()
    sys.exit(0)


if results.host:
    host = results.host

connection = create_connection(':memory:')
create_table(connection, gcp_instances)

gcp_json = subprocess.check_output('gcloud compute instances list --format=json', shell=True)
data = json.loads(gcp_json)

for instance in data:
    ins_tags = ', '.join(instance["tags"]["items"])
    ins_name = instance["name"]
    ins_ext_ip = instance["networkInterfaces"][0]["accessConfigs"][0]["natIP"]
    ins_int_ip = instance["networkInterfaces"][0]["networkIP"]

    insert_result_data = 'INSERT INTO gcp_instances ( name, ext_ip, int_ip, tags) VALUES (?, ?, ?, ?)'
    result = (ins_name, ins_ext_ip, ins_int_ip, ins_tags)
    try:
        c = connection.cursor()
        c.execute(insert_result_data, result)
    except Error as e:
        print(e)

json_ins = {'_meta': {'hostvars': {}}}

sql = 'SELECT tags FROM gcp_instances WHERE name LIKE "%'+host+'%" GROUP BY tags '
for tag in sql_query(connection, sql):
    sql = 'SELECT name FROM gcp_instances WHERE (tags LIKE "%'+tag[0]+'%") and (name LIKE "%'+host+'%")'
    instances = []
    for instance in sql_query(connection, sql):
        instances.append(instance[0])
    json_ins[tag[0].split("-")[1]] = {'hosts': instances}

sql = 'SELECT * FROM gcp_instances WHERE (tags LIKE "%docker-host%") and (name LIKE "%'+host+'%")'
for row in sql_query(connection, sql):
    json_ins['_meta']['hostvars'][row[1]] = {'ansible_host' : row[2], 'int_ip' : row[3]}



print(json.dumps(json_ins, indent=4, sort_keys=True))
