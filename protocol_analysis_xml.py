#!/usr/bin/python3

import xml.sax
import os

class IPPackageHandler( xml.sax.ContentHandler ):
   def __init__(self):
      self.CurrentData = ""
      self.type = ""
      self.path = ""


   # 元素开始调用
   def startElement(self, tag, attributes):
      self.CurrentData = tag
      if tag == "IP":
         pcappath = attributes["title"]
         print ("pcap:", pcappath)

   # 元素结束调用
   def endElement(self, tag):
      if self.CurrentData == "type":
         print ("Type:", self.type)
      elif self.CurrentData == "path":
         print ("path:", self.path)
      self.CurrentData = ""

   # 读取字符时调用
   def characters(self, content):
      if self.CurrentData == "type":
         self.type = content
      elif self.CurrentData == "path":
         self.path = content
 
if ( __name__ == "__main__"):
   
   # 创建一个 XMLReader
   parser = xml.sax.make_parser()
   # 关闭命名空间
   parser.setFeature(xml.sax.handler.feature_namespaces, 0)

   # 重写 ContextHandler
   Handler = IPPackageHandler()
   parser.setContentHandler( Handler )   
   parser.parse("IPpackage.xml")

   print("/root/SW_ARM_DPDK/PcapPlusPlus/Examples/ProtocolAnalysis/Bin/ProtocolAnalysis   %s"%(Handler.path))
   os.system("/root/SW_ARM_DPDK/PcapPlusPlus/Examples/ProtocolAnalysis/Bin/ProtocolAnalysis   %s"%(Handler.path))