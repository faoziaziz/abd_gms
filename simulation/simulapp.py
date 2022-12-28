import pyqrcode
from pyqrcode import create
import tkinter as tk
from tkinter import * 
from threading import *
import png # pip install pypng ## to save in png format
import json 
import requests

my_w = tk.Tk()
my_w.geometry("410x400")  # Size of the window 
my_w.title("anggap saja tenant")  # Adding a title

e1=tk.Entry(my_w,font=22,bg='yellow',width=15)
e1.grid(row=0,column=0,padx=10,pady=10)
b1=tk.Button(my_w,font=22,text='Generate QR code',
    command=lambda:my_generate())
b1.grid(row=0,column=1,padx=5,pady=10)

l1=tk.Label(my_w,text='QR to display here')
l1.grid(row=1,column=0,columnspan=2)


# code simpanan
def checkSession():
    #check session
    url = 'https://www.simpade.com:4646/checksession?tenant=warungbarokah'
    x = requests.post(url, verify=False) 
    print(x.text) 
    json_check  = json.loads(x.text) 
    print("index_session : "+str(json_check["index_ses"]))

def postCloseSes():
    urlCloseSes = 'https://www.simpade.com:4646/closesession?id_sn=2&flag=19'
    postClosedata = requests.post(urlCloseSes, verify=False)
    print(postClosedata.text)

def postsetdata():
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
    
def threading():
    t1=Thread(target=work);
    
def my_generate():
    global my_img
    my_qr = pyqrcode.create(e1.get()) 
    #my_qr.svg('G:\\My Drive\\testing\\my_qr.svg', scale=8)#save svg
   # my_qr.png('G:\\My Drive\\testing\\my_qr1.png', scale=6, 
    #    module_color=[0, 0, 0, 128], background=[0xff, 0xcc, 0xcc])
   # my_qr.show() # display qr code image  in console 
    my_qr = my_qr.xbm(scale=10)
    my_img=tk.BitmapImage(data=my_qr)
    l1.config(image=my_img) # Show the qr code in Label 
    

my_w.mainloop()  # Keep the window open