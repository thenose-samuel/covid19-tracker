import requests
from bs4 import BeautifulSoup
import json
#scraping functions
keys = ["Active","Deceased","Recovered","Positive"]
def changeChecker(currentData,lastData):
	changedValues = []
	if(currentData['meghalaya'][keys[0]]!=lastData['meghalaya'][keys[0]]):
		changedValues.append(keys[0])
	if(currentData['meghalaya'][keys[1]]!=lastData['meghalaya'][keys[1]]):
		changedValues.append(keys[0])
	if(currentData['meghalaya'][keys[2]]!=lastData['meghalaya'][keys[2]]):
		changedValues.append(keys[0])
	if(currentData['meghalaya'][keys[3]]!=lastData['meghalaya'][keys[3]]):
		changedValues.append(keys[0])
	return changedValues
def difference(current,last):
	diff = int(current) - int(last)
	if(diff>0):
		return "+{}".format(abs(diff))
	elif(diff<0):
		return "-{}".format(abs(diff))
def meghalaya():
	history = {}
	with open("data/meghalaya.json",'r') as historyObj:
		history = json.load(historyObj)
	#initialize the data dictionary
	data = {}
	data['meghalaya'] = {}
	url = "http://meghalayaonline.gov.in/covid/login.htm#"
	r = requests.get(url)
	soup = BeautifulSoup(r.content,'html5lib')
	val = soup.findAll('span',attrs = {'class':'values'})
	labels = soup.findAll('span',attrs = {'class':'labels'})
	for i in range(len(val)-1):
		data["meghalaya"][labels[i].text.strip()] = val[i].b.text.strip()
	changedKeys = changeChecker(data,history)
	changes = {}
	for key in changedKeys:
		changes[key] = difference(data['meghalaya'][key],history['meghalaya'][key])
	print(changes)
meghalaya()