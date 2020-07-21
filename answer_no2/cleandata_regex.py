import csv
import re

with open('raw_data.csv') as raw_data:
    print("data before cleansing using regex")
    print(raw_data.read())
    
with open('raw_data.csv') as raw_data:
    for line in raw_data.readlines():
        #regex = re.sub(r"[^ -~]"," ",line)
        regex = re.sub(r"[^a-zA-Z0-9]","",line)
        print("data after cleansing using regex")
        print(regex, end="\n")
