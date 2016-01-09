import os,sys,shutil
import pyotherside
import subprocess
import urllib
import urllib.request
import imghdr
from basedir import *
import hashlib

cachePath=XDG_CACHE_HOME+"/harbour-oschina/osc/"
savePath=HOME+"/Pictures/save/osc/"

def saveImg(md5name,savename):
    try:
        realpath=cachePath+md5name
        isExis()
        shutil.copy(realpath,savePath+savename+"."+findImgType(realpath))
        pyotherside.send("1")
    except:
        pyotherside.send("-1")

def isExis():
    if os.path.exists(savePath):
        pass
    else:
        os.makedirs(savePath)

"""
    缓存图片
"""
def cacheImg(url):
    cachedFile = cachePath+sumMd5(url)
    if os.path.exists(cachedFile):
        pass
    else:
        #downloadImg(cachedFile,url)
        default_avatar = downloadImg(cachedFile,url)
        if default_avatar == "default":
            return ""
    #判断图片格式
    return cachedFile

"""
    下载文件

"""
def downloadImg(downname,downurl):
    try:
        urllib.request.urlretrieve(downurl,downname)
    except urllib.error.HTTPError:
        return "default"
    except urllib.error.ContentTooShortError:
        return "default"
    return ""


def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")

#判断图片格式
def findImgType(cachedFile):
    imgType = imghdr.what(cachedFile)
    return imgType

def sumMd5(s):
    m = hashlib.md5()
    if isinstance(s,str):
        s = s.encode("utf-8")
    m.update(s)
    return m.hexdigest()
