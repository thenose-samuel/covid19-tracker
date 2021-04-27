import requests
from bs4 import BeautifulSoup
import csv


def meghalaya():
	url = "http://meghalayaonline.gov.in/covid/login.htm#"
	r = requests.get(url)

	soup = BeautifulSoup(r.content,'html5lib')

	data = dict()
	val = soup.findAll('span',attrs = {'class':'values'})
	labels = soup.findAll('span',attrs = {'class':'labels'})
	for i in range(len(val)-1):
		data[labels[i].text.strip()] = val[i].b.text.strip()
	for key in data:
		print(key,':',data[key])
	return

#main
meghalaya_data = meghalaya()
