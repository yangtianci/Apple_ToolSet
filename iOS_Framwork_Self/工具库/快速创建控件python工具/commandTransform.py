
#coding=utf-8


import json 
import sys



reload(sys)
sys.setdefaultencoding('utf-8')

outterlineArr=[] 

innterLineArr=[]


class codeTransformer(object):
	"""docstring for codeTransformer"""

	jsonMap = {} 
	jsonMap_Proerty = {}

	def __init__(self):
		super(codeTransformer, self).__init__()
		

		
# 拆分输入文本 
	def AnalyzeMethod(self,shortCodeStr):

		with open('/Users/yangtianci/Desktop/快速创建属性工具/jsonMap_init.json') as fo:
		 	self.jsonMap = json.load(fo,encoding='utf-8') 
			pass

		with open('/Users/yangtianci/Desktop/快速创建属性工具/jsonMap_property.json') as fo:
			self.jsonMap_Proerty = json.load(fo,encoding='utf-8') 
			pass

		totalCode = self.analyze_to_Row(shortCodeStr) 
		print totalCode 
	pass



# 将完整输入拆分为模块层级的行 
	def analyze_to_Row(self,totalInputStr):

		totalStr = '' 

		rowArr = totalInputStr.split('\n') 

		for x in xrange(0,len(rowArr)):

			rowStr = self.analyze_to_Module_Properties(rowArr[x])	
			totalStr += rowStr 

			pass

		return totalStr 

		pass

# 将模块层级的行拆分为: 模块名 & 多个属性 
	def analyze_to_Module_Properties(self,rowInputStr):

		print rowInputStr 

		totalRowStr = '' 

		rowArr = rowInputStr.split('-') 
		str = "#pragma mark ========================%(txt)s \n"%{'txt':rowArr[0]} 
		totalCode = self.analyze_to_PropertyArr(rowArr[1],str)  

		totalRowStr += totalCode 

		return totalRowStr 

		pass

# 将多个属性拆分为数组并根据 type name 的形式获取对应的成型代码 
	def analyze_to_PropertyArr(self, prosStr,moduleName):

		totalCodeStr = ''
		totalCodeStr += moduleName

		proArr = prosStr.split(';') 
		for x in xrange(0,len(proArr)): 
			proCode = self.analyze_to_PropertyCode(proArr[x])
			# totalCodeStr += '\n' 
			totalCodeStr += proCode  
			pass
		totalCodeStr += '\n\n\n'			

		totalCodeStr += moduleName

		totalCodeStr += self.analyze_to_ConfigMethod(prosStr) 

		totalCodeStr += '\n\n\n'	

		totalCodeStr += moduleName

		for x in xrange(0,len(proArr)):
			initCode = self.analyze_to_initCode(proArr[x]) 
			totalCodeStr += initCode 
			totalCodeStr += '\n\n\n\n'
			pass

		return totalCodeStr 
		pass


# type name ===> 属性 
	def analyze_to_PropertyCode(self, proStr):
		arr = proStr.split() 


		tapStr='' 
		if arr[0]== 'UIView' or arr[0]== 'UILabel' or arr[0]== 'UIButton' or arr[0]== 'UIImageView' or arr[0]== 'UITextField' or arr[0]== 'UIScrollView' or arr[0]== 'NSMutableArray' or arr[0] == 'NSIndexPath' :
			tapStr = self.jsonMap_Proerty['Objc']
			pass

		if arr[0]=='BOOL' or arr[0]=='NSInteger' or arr[0]=='CGFloat':
			tapStr = self.jsonMap_Proerty['Assign']
			pass

		if arr[0]=='NSArray' or arr[0]=='NSString':
			tapStr = self.jsonMap_Proerty['Copy']
			pass

		totalStr = ''
		# propertyString = "@property (strong, copy) %(type)s *%(name)s; \n"%{'type':arr[0],'name':arr[1]}
		
		tapStr = tapStr.replace('<#type#>',arr[0]) 
		tapStr = tapStr.replace('<#name#>',arr[1]) 
		tapStr += '\n'

		return tapStr 
		pass


# # type name ===> ConfigUI 函数 
	def analyze_to_ConfigMethod(self,proArr):
		totalCodeStr = '\n'
		proarr = proArr.split(';') 
		egStr = "[<#SuperView#> addSubview:self.<#name#>];\n[self.<#name#> mas_makeConstraints:^(MASConstraintMaker *make) {\n<#LayoutCode#>\n}];"

		for x in xrange(0,len(proarr)):

			totalCodeStr += '\n'
			pro = proarr[x]
			arr = pro.split()

			if arr[0]== 'UIView' or arr[0]== 'UILabel' or arr[0]== 'UIButton' or arr[0]== 'UIImageView' or arr[0]== 'UITextField' or arr[0]== 'UIScrollView':
				eg = egStr.replace('<#name#>',arr[1])
				totalCodeStr += eg 
				totalCodeStr += '\n'
			pass 

		totalCodeStr += '\n'
		totalCodeStr = '-(void)ConfigUI{%(content)s}'%{'content':totalCodeStr}

		return totalCodeStr 
	 	pass 


# # # type name ===> 初始化代码  
	def analyze_to_initCode(self,proStr): 

		arr = proStr.split() 

		orgCode = self.jsonMap[arr[0]] 
		orgCode = orgCode.replace("<#name#>",arr[1])

		return orgCode

		pass



print('''通过指定语法快速创建 iOS GUI 界面代码组件 \n 
		输入参数: '模块名-type name1;type name2;type name3;' \n 
		布局方式: 布局方式通过文件外参数传入 f-frame/m-masonry \n 
		最后一个属性千万不要加 ; 符号 \n 
		算了, 他妈的只支持单行创建好了, 太麻烦了, 都已经十二点了 
		输出格式:  \n
		#pragma mark ================= 模块名 
		
		view coding... \n 

		
		''') 

transform = codeTransformer() 


# testStr = 'ceshiModeulName-UIView topView;UILabel tileLab;UIImageView iconImg; NSArray demoArr'

commandStr = sys.argv[1]
codeTransformer.AnalyzeMethod(transform,commandStr) 







