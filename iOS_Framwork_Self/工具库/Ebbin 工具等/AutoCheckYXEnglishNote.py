#coding=utf-8 


import wx
import requests
import time
from io import BytesIO
from PIL import Image
import re
from lxml import etree
from selenium import webdriver 
from selenium.webdriver.common.keys import Keys
import datetime  
import sys





###################### GUI 相关 


def GUIShowMethod(WrapperArr, AimCount):


	app = wx.App(False)

	frame = wx.Frame(None, wx.ID_ANY,size=(650,750), title="Ebbins-english")
	pannel = wx.ScrolledWindow(frame, wx.ID_ANY, pos=(10,10), size=(300,300), name="PanelNameStr") 
	pannel.SetScrollbars(0, 20, 20, 60)


	aimCountStr = 'english - 检索到 %d 篇' % AimCount 
	label = wx.TextCtrl ( pannel,pos=(20, 10),size=(600,30),value = aimCountStr,style = wx.TE_READONLY | wx.TE_CENTER )

	testView(WrapperArr,pannel) 

	frame.Show(True)

	app.MainLoop()


	pass


def testView(WrapperArr,superV):

	TotalY = 55 

	for x in xrange(0,len(WrapperArr)):

		# 获取内部小数组 
		innerArr = WrapperArr[x] 

		for j in xrange(0,len(innerArr)):

			x = 20 
			y = TotalY 

			str = ''
			if type(innerArr[j]) == type([]):

				str = '   .   '.join(innerArr[j])

			else:
				str = innerArr[j]

				pass

			label = wx.TextCtrl ( superV,pos=(x, y),size=(600,30),value =str ,style = wx.TE_READONLY | wx.TE_LEFT )

			TotalY += 28 
			if j == len(innerArr)-1:
				TotalY += 10 
				pass

			pass

		pass

	pass



# 测试代码 
# wrapperArr1 = [] 
# wrapperArr1.append(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>_1") 
# wrapperArr1.append(['20190711', '20190710', '20190709']) 
# wrapperArr1.append(['=================', '0', '0'])

# Tarr = []

# for x in xrange(0,12):
# 	Tarr.append(wrapperArr1);
# 	pass

# GUIShowMethod(Tarr)





######################## Ebbins 本身数据 

reload(sys)  
sys.setdefaultencoding('utf8')   

pwd = sys.argv[1] 

dayCount = 3 

########################## 

browser = webdriver.Chrome()

# 设置隐式等待, 取代手动 sleep   

browser.implicitly_wait(5) 


browser.get("https://app.yinxiang.com/Login.action?targetUrl=%2FHome.action%3Flogin%3Dtrue#n=8aae2d58-e184-41c3-804e-31c0624643e7&s=s69&ses=4&sh=2&sds=5&")
browser.find_element_by_id("username").send_keys("624946274@qq.com")
browser.find_element_by_id("loginButton").click() 

time.sleep(1)

browser.find_element_by_id("password").send_keys(pwd) 
browser.find_element_by_id("loginButton").click() 

print "等待开始"

# time.sleep(30) 

print "等待完成"

browser.find_element_by_id('gwt-debug-Sidebar-searchButton').click() 

# print "总不能提前执行这句吧" 

# 获取 ebbin 时间点并形成数组 
def getEbbinDaysArr():

	resultArr = []

	innerArr = ['0','1','2','4','7','15','22','30','45', '60', '100','180']  
	for x in xrange(0,len(innerArr)): 
		innerDays = innerArr[x] 
		today = datetime.date.today()
		aimDay = today - datetime.timedelta(days=int(innerDays))  
		aimStr = aimDay.strftime('%Y-%m%d') 

		one = aimDay - datetime.timedelta(days=1) 
		oneStr = one.strftime('%Y-%m%d') 

		two = aimDay - datetime.timedelta(days=2) 
		twoStr = two.strftime('%Y-%m%d') 
		

		if dayCount==2:
			aimArr = [aimStr, oneStr] 
		else:
			# two = aimDay - datetime.timedelta(days=2) 
			aimArr = [aimStr, oneStr, twoStr] 
			pass

		resultArr.append(aimArr) 
		pass

	# for x in xrange(0,len(resultArr)):

	# 	arr = resultArr[x] 
	# 	print '\n' 
	# 	print arr  
	# 	pass
	print resultArr 

	return resultArr 

	pass

ebbinArr = getEbbinDaysArr() 


def  EnumeNoteMethod(): 

	resultArr = [] 
	for x in xrange(0,len(ebbinArr)):
		
		objArr = ebbinArr[x]
		smallArr = []
		for y in xrange(0,len(objArr)): 
			date = objArr[y] 
			str = date  # 正常 ebbin 时这里会接受 date, 英语 ebbin 会接受字符串 
			isHave = checkNoes(str)
			if isHave == 1:
				smallArr.append('=================')
			else: 
				smallArr.append('0') 
				pass
			pass
		resultArr.append(smallArr) 
		pass

	return resultArr 

	pass


def checkNoes(str): 

	# 清除 
	browser.find_element_by_id("gwt-debug-searchViewSearchBox").clear()
	# 输入 
	browser.find_element_by_id("gwt-debug-searchViewSearchBox").send_keys(str) 
	# 查找 
	browser.find_element_by_id('gwt-debug-searchViewSearchBox').send_keys(Keys.ENTER)

	time.sleep(1) 

	print '开始检查 >>>>>>>>>>>>>>>>> ' + str  


	# 判断 
	str = browser.find_element_by_class_name('focus-NotesView-Subheader').text
	# str = str.decode('utf-8')

	str = str.split('\n')[0] 
	str = re.findall(r"\d+\.?\d*",str)[0]  

	# print '检查到' + str + '篇笔记' 
	# print '\n'

	if int(str) > 0:
		# 证明此天有需要复习的笔记 
		# print 'str > 0' + str 
		return 1
	else:
		# print 'str !> 0' + str 
		return 0 
		pass

	print '\n' 

	pass


Arr =  EnumeNoteMethod()  


print '\n'

wrapperArr = [] 
aimcount = 0 
 
for x in xrange(0,len(ebbinArr)):

	dateObj = ebbinArr[x] 
	textObj = Arr[x] 

	tempArr = [] 
	for y in xrange(0,len(dateObj)):
		date = dateObj[y] 
		# tempArr.append(date.strftime('%Y%m%d'))
		tempArr.append(date)
		pass

	idx = str(x+1) 

	tag = '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>__' + idx 
	print tag 
	print tempArr 
	print textObj 

	innerArr = [] 

	# tagStr = ','.join(tag)
	innerArr.append(tag) 

	tempStr = '  .  '.join(tempArr)
	innerArr.append(tempStr)

	innerStr = '  .  '.join(textObj)
	innerArr.append(textObj) 

	for x in xrange(0,len(textObj)):
		resStr = textObj[x]
		if resStr == '=================':
			aimcount += 1
			pass
		pass

	wrapperArr.append(innerArr) 

	pass

# 关闭浏览器 

browser.quit() 


# GUI 展示 
GUIShowMethod(wrapperArr,aimcount)  


print '\n' 

















