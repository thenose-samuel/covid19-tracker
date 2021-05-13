import json
with open("data/meghalaya.json",) as fileObj:
	lastData = json.load(fileObj)
with open("data/meghalaya.json",'r') as historyObj:
	history = json.load(fileObj)

