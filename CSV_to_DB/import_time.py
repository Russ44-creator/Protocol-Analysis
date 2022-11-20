import time

from watchdog.events import *
from watchdog.observers import Observer


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
            # 判断是哪个数据库



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
