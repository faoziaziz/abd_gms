# -*- coding: utf-8 -*-
"""
Created on Wed Dec 14 10:14:47 2022

@author: Marinir
"""

import datetime
import os
import sqlalchemy as db
from sqlalchemy import Column, ForeignKey, Integer, String, Numeric, DateTime, ForeignKey, CHAR, Table 

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

import uvicorn
from fastapi import FastAPI
import nest_asyncio
from pydantic import BaseModel

CONNECTIONSTRING="mysql+mysqlconnector://20022001:Aziztampan1234@localhost/GlucoseDatabase"

engine = create_engine(CONNECTIONSTRING)

Base = declarative_base(engine)

Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)
session = DBSession()

connection = engine.connect()
metadata = db.MetaData()

class Glucosetab(Base):
    __tablename__="GlucoseTable"
    __table_args__ ={"autoload": True}
    
class Usertypetab(Base):
    __tablename__="UserTypeTable"
    __table_args__ ={"autoload": True}

class Sessiontab(Base):
    __tablename__="sessionTab"
    __table_args__ ={"autoload": True}
    
app=FastAPI(title="Glucose Api",
    description="Just glucose simple api",)


class SetItem(BaseModel):
    idtrans: str
    glucose_level: int
    date_time: str
    user: str
    tenant: str

class SessionItem(BaseModel):
    index_ses: int
    datetimer_s: str 
    user: str 
    tenant: str 
    flag: int 

@app.get("/")
async def status():
    return {"test": "tester ok"}

@app.post("/setdata")
async def setdata(setItem: SetItem):
    """this function just write to database this is """
    glucose_insert = Glucosetab(username=setItem.user, DataCaptured=setItem.glucose_level, tenant=setItem.tenant)
    session.add(glucose_insert)
    session.commit()
    

    return {"status": 4}

@app.post("/createsession")
async def createSession(sessionItem: SessionItem):
    session_insert = Sessiontab(datetimer_s=sessionItem.datetimer_s, user=sessionItem.user, tenant=sessionItem.tenant, flag=sessionItem.flag )
    session.add(session_insert)
    session.commit()
    return {"status": 1}

@app.post("/checksession")
async def checkSession(tenant: str = "warungbunyamin"):
    """check status flags in session coloumn to make sure the device ready to capture glucose"""
    FT2 = session.query(Sessiontab).filter(db.and_(Sessiontab.tenant == tenant, Sessiontab.flag ==0))
    if FT2 != None:
        if(FT2.count()<1):
             return {"status": 2,  "index_ses": 0}
        else: 
            return {"status": 0, "index_ses": FT2[0].index_ses}
    else:
        return {"status": 1,  "index_ses": 0}
        

@app.post("/closesession")
async def closeSession(id_sn: int, flag: int):
    """update the flag to make sure the device done when capture"""
    ses_update = session.query(Sessiontab).filter(Sessiontab.index_ses==id_sn).first()
    ses_update.flag = flag
    session.commit()

    return {"setSession": 1}

@app.get('/getdata')
async def GetData(user: str = "string"):
    """get data api"""
    glucoseList = []

    try:
        glucoses = session.query(Glucosetab).all()
        
        for item in glucoses:
            #contactType = session.query(ContactType).filter(ContactType.ContactTypeId == item.ContactTypeId).one()
            #emails = [item.__dict__ for item in session.query(Email).filter(Email.ContactId == item.ContactId)]
            #phoneNumbers = [item.__dict__ for item in session.query(PhoneNumber).filter(PhoneNumber.ContactId == item.ContactId)]

            glucose = {
                "idtrans": item.ID_glc,
                "glucose_level": item.DataCaptured,
                "date_time": item.Datestamp,
                "user": item.username,
                "tenant":item.tenant
            }

            if(item.username==user):
                glucoseList.append(glucose)
        #print(transList)
    except:
        session.rollback()
        raise

    return {"data": glucoseList, "status": 1}

nest_asyncio.apply()
#uvicorn.run(app, port=4646, host='0.0.0.0', log_level="info")

uvicorn.run(app, port=4646, host='0.0.0.0', log_level="info", ssl_keyfile="privkey.pem", ssl_certfile="cert.pem")
