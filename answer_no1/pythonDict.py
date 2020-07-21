import csv
reader = csv.DictReader(open('test.csv'))
for row in reader:
    print(row)