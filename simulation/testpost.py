# -*- coding: utf-8 -*-
"""
Created on Thu Dec 15 19:27:12 2022

@author: Marinir
"""

import requests
import json

#check session
url = 'https://www.simpade.com:4646/checksession?tenant=warungbarokah'

myobj = {
  "status": 2,
  "index_ses": 0
}


x = requests.post(url, verify=False)
print(x.text)
json_check  = json.loads(x.text)
print("index_session : "+str(json_check["index_ses"]))



# set data 
urlPostData = 'https://www.simpade.com:4646/setdata'

setDataObj = {
  "idtrans": "string",
  "glucose_level": 210,
  "date_time": "string",
  "user": "rahvanafaozi@gmail.com",
  "tenant": "warungbarokah"
}

postsetdata = requests.post(urlPostData, json = setDataObj, verify=False)
print(postsetdata.text)


# close data
urlCloseSes = 'https://www.simpade.com:4646/closesession?id_sn=2&flag=19'

postClosedata = requests.post(urlCloseSes, verify=False)
print(postClosedata.text)