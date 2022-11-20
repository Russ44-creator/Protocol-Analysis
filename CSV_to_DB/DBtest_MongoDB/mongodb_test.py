from pymongo import MongoClient
import csv
import time
def connect_mongo():
    # mongo_uri = 'mongodb://user_name:password@host:port/Validate the database'
    # client = pymongo.MongoClient(mongo_uri, readPreference='write as required')
    client = MongoClient('127.0.0.1', 27017)
    db = client.test
    collection = db['testdemo']
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


            
# if __name__=='__main__':
#     print(time.strftime('%Y-%m-%d %H:%M:%S'))#for calculating time
#     set1 = connect_mongo()
#     insertToMongoDB(set1,"test1.csv")
#     print(time.strftime('%Y-%m-%d %H:%M:%S'))

