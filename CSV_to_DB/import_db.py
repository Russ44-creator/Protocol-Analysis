#/bin/python3
import time

from watchdog.events import *
from watchdog.observers import Observer
from sqlalchemy import create_engine, types
import os
import configparser

from pymongo import MongoClient
import csv

import re


import pymysql

def connect_mongo():
    # mongo_uri = 'mongodb://user_name:password@host:port/Validate the database'
    # client = pymongo.MongoClient(mongo_uri, readPreference='write as required')
    client = MongoClient('127.0.0.1', 27017)
    db = client.test
    collection = db['test1']
    return collection
    #集合
def insertToMongoDB(set1,datafile):
    with open(datafile,'r',encoding='utf-8') as csvfile:
        # Call the DictReader function in csv to directly obtain the data in the form of a dictionary
        reader = csv.DictReader(csvfile)
        csv_data = []
        # Create a counts to count how many pieces of data have been added
        counts = 0
        index = 1
        for each in reader:
            csv_data.append(each)
            if index==10000:#Write to MongoDB after 10,000
                set1.insert_many(csv_data)
                csv_data.clear()
                index = 0
                print("successfully added" + str(counts) + "data")
            counts+=1
            index+=1
        if len(csv_data)>0:#remain data
            set1.insert_many(csv_data)
            print("Successfully added %s data"%len(csv_data))


# 读取配置文件
def getConfig(filename, section, option):
    """
    :param filename 文件名称
    :param section: 服务
    :param option: 配置参数
    :return:返回配置信息
    """
 	 # 获取当前目录路径
    proDir = os.path.split(os.path.realpath(__file__))[0]
    # print(proDir)

    # 拼接路径获取完整路径
    configPath = os.path.join(proDir, filename)
    # print(configPath)

    # 创建ConfigParser对象
    conf = configparser.ConfigParser()

    # 读取文件内容
    conf.read(configPath)
    config = conf.get(section, option)
    return config






class FileEventHandler(FileSystemEventHandler):
    def __init__(self):
        FileSystemEventHandler.__init__(self)

    # def on_moved(self, event):
    #     if event.is_directory:
    #         print("directory moved from {0} to {1}".format(event.src_path, event.dest_path))
    #     else:
    #         print("file moved from {0} to {1}".format(event.src_path, event.dest_path))

    # def on_created(self, event):
    #     if event.is_directory:
    #         print("directory created:{0}".format(event.src_path))
    #     else:
    #         print("file created:{0}".format(event.src_path))

    # def on_deleted(self, event):
    #     if event.is_directory:
    #         print("directory deleted:{0}".format(event.src_path))
    #     else:
    #         print("file deleted:{0}".format(event.src_path))

    # def on_modified(self, event):
    #     if event.is_directory:
    #         print("directory modified:{0}".format(event.src_path))
    #     else:
    #         print("file modified:{0}".format(event.src_path))

    def on_closed(self, event):

        if event.is_directory:
            print("directory closed:{0}".format(event.src_path))
        else:
            print("file closed:{0}".format(event.src_path))
            #1. 判断是否是csv文件 
            if (re.split('\.',event.src_path)[-1] != "csv"):
                print("不是csv文件")
            else:
                #2. 判断是哪个数据库
                db = getConfig("config.ini", 'DB', 'db')
                print(db)
                if (db == "mysql") :
                    pymysql.install_as_MySQLdb()
                    engine = create_engine('mysql://root:q@localhost:3306/test')
                    print(db)
                    import pandas as pd
                    df = pd.read_csv(event.src_path)
                    print(df)
                    df.to_sql('testdemo',con=engine,index=False,if_exists='replace')
                    print("连接mysql,导入文件成功")
                    print('导入成功')

                elif (db == "mongodb") :
                    print(db)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
                    set1 = connect_mongo()
                    insertToMongoDB(set1,event.src_path)
                    print("连接mongodb,导入文件成功")
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))
                elif (db == "oracle") :
                    print(db)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
                    set1 = connect_mongo()
                    insertToMongoDB(set1,event.src_path)
                    print("连接Oracle,导入文件成功")
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))
                elif (db == "Gbase") :
                    print(db)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
                    print("连接Gbase,导入文件成功")
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))
                elif (db == "ES") :
                    print(db)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
                    #set1 = connect_mongo()
                    #insertToMongoDB(set1,event.src_path)
                    print("连接ES存储,导入文件成功")
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))
                elif (db == "psql") :   
                    os.system("sh psql.sh &")
                else :
                    print("没有这个数据库；")



if __name__ == "__main__":
    observer = Observer()
    event_handler = FileEventHandler()
    dbdir = getConfig("/etc/config.ini", 'DB', 'dbdir')
    observer.schedule(event_handler, dbdir, True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
