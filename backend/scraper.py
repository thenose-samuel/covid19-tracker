import requests
from bs4 import BeautifulSoup

#scraping functions
def meghalaya():
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
	return data


