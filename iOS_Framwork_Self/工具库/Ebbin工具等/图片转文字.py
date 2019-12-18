#coding:utf-8 




from PIL import Image 
import pytesseract 

import os
import re 
import sys

reload(sys)
sys.setdefaultencoding('utf-8')
 

print('第一个参数是图片路径'+'第二个参数是文本名称') 

imgurl = sys.argv[1] 
txturl = sys.argv[2] 

def ImageToString(imgurl, txturl): 

	if len(imgurl) == 0:
		print('第一个参数是图片路径')
		pass

	if len(txturl) == 0:
		print('第二个参数是文本名称') 
		pass


	img =  Image.open(imgurl)
	text=pytesseract.image_to_string(img, lang='chi_sim') # 

	# print(text) 

	txtPath = os.path.dirname(imgurl)+'/'+txturl 
	print('导出文本地址'+txtPath) 

	with open(txtPath, "a+") as fo:
	        fo.write(text) 
	pass

    
ImageToString(imgurl,txturl) 







 