import time

from watchdog.events import *
from watchdog.observers import Observer

import os
import configparser

import re

import CSV_to_DB/DBtest/main.py
import CSV_to_DB/DBtest_MongoDB/main.py

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
                    print(db)
                    df = pd.read_csv(event.src_path)
                    print(df)
                    df.to_sql('testdemo',con=engine,index=False,if_exists='replace')
                    print('导入成功')

                elif (db == "mongodb") :
                    print(db)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
                    set1 = connect_mongo()
                    insertToMongoDB(set1,event.src_path)
                    print(time.strftime('%Y-%m-%d %H:%M:%S'))
                else :
                    print("没有这个数据库；")



if __name__ == "__main__":
    observer = Observer()
    event_handler = FileEventHandler()
    observer.schedule(event_handler, "/workspaces/SW_ARM_DPDK/CSV_to_DB/data/", True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
