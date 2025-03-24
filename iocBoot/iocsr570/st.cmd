#!../../bin/linux-x86_64/sr570

#- You may have to change sr570 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components

dbLoadDatabase "${TOP}/dbd/sr570.dbd"
sr570_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/sr570App/Db")
epicsEnvSet("PREFIX", "BL62:SR570:")
epicsEnvSet("PORT", "serial3")
epicsEnvSet("M","M1:")
#drvAsynIPPortConfigure("serial3", "192.168.0.5:4003 COM", 0, 0, 0)
drvAsynSerialPortConfigure("serial3", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial3",0,"\r\n")
asynOctetSetOutputEos("serial3",0,"\r\n")
dbLoadRecords("${TOP}/sr570App/Db/sr570.db","P=$(PREFIX),M=$(M),PORT=serial3")
set_pass0_restoreFile("sr570_settings.sav")
cd ${TOP}/iocBoot/iocsr570
< autosave.cmd

dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn3,PORT=serial3,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial3")

iocInit()
create_monitor_set("sr570_settings.req", 30, "P=$(PREFIX)")


