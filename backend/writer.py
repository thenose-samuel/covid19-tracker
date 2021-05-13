from scraper import*
from time import time
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

final_data = {}
final_data.update(meghalaya())
print(final_data)
with open('covid_data.json','w') as json_file:
	json.dump(final_data,json_file)
test = {'hello world':'This is a test'}
cred = credentials.Certificate("C:\covid19-tracker-3c115-firebase-adminsdk-bnrg4-7f5d6b6b56.json")
firebase_admin.initialize_app(cred,{'databaseURL': 'https://covid19-tracker-3c115-default-rtdb.firebaseio.com'})
ref = db.reference('/')
ref.set(final_data)
