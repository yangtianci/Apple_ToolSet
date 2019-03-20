//
//  YtcSimpleImagesView.m
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "YtcSimpleImagesView.h"

#import "YtcSimpleImageCell.h"


#define itemWidth ( self.frame.size.width - self.RightLeftMargin *2 - self.MiddleVerticalMargin * (self.columCount - 1) ) / self.columCount

#define itemHeight itemWidth/self.WidthHeigthPercent


@interface YtcSimpleImagesView ()<UICollectionViewDelegate,UICollectionViewDataSource>


// ====================================================================


// ====================================================================

@property (strong, nonatomic) UICollectionViewFlowLayout *flow;

@property (strong, nonatomic) UICollectionView *mainCollectionView;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end


@implementation YtcSimpleImagesView




#pragma mark ================= 数据绑定 channel

-(void)ConfigImgArr:(NSArray *)imgArr CallBack:(void (^)(CGRect))callBack{
    
    self.dataArr = [NSMutableArray arrayWithArray:imgArr];
    _flow.itemSize = CGSizeMake(itemWidth, itemHeight);
    [self.mainCollectionView reloadData];
    
    if (callBack) {
        
        CGFloat H = [self caculateTheight];
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, H);
        
        self.mainCollectionView.frame = frame;
        
        callBack(frame);
    }
    
}


#pragma mark ============================================== logic

// 计算高度
-(CGFloat)caculateTheight{
    
    CGFloat tHeight;
    
    if (self.dataArr.count >= self.maxImgCount) {
        
        NSInteger row = ceil(self.dataArr.count/_columCount);
        
        tHeight  = _TopMargin + _BottomMargin + row * itemHeight + (row - 1) * _MiddleHorizonMargin;
    }else{
        NSInteger row = ceil((self.dataArr.count + 1)/_columCount);
        tHeight  = _TopMargin + _BottomMargin + row * itemHeight + (row - 1) * _MiddleHorizonMargin;
    }
    return tHeight;
    
}


#pragma mark ================= 设置完数据后调用函数初始化

-(void)ShowTime{
    
    [self ConfigUI];
    [self ConfigLogic];
    
}


#pragma mark ============================================== 初始化

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self InitData];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self InitData];
}

-(void)InitData{
    
    self.dataArr = [NSMutableArray array];
    
    self.maxImgCount = 9;
    
    self.TopMargin = 10;
    self.RightLeftMargin = 15;
    self.BottomMargin = 10;
    
    self.MiddleVerticalMargin = 5;
    self.MiddleHorizonMargin = 5;

    self.WidthHeigthPercent = 1.0;
    self.columCount = 3;

    self.canEdit = YES;
    
}


-(void)ConfigUI{
    
    self.mainCollectionView.frame = self.bounds;
    
    [self addSubview:self.mainCollectionView];
    
    [self.mainCollectionView reloadData];
    
}



-(void)ConfigLogic{
    
    __weak typeof(self)WS = self;
    
}


#pragma mark ============================================== Lazy


-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flow];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [_mainCollectionView registerNib:[UINib nibWithNibName:@"YtcSimpleImageCell" bundle:nil] forCellWithReuseIdentifier:identifier_CollectionView];
        
    }
    return _mainCollectionView;
}


-(UICollectionViewFlowLayout *)flow{
    if (!_flow) {

        _flow = [[UICollectionViewFlowLayout alloc]init];
        _flow.itemSize = CGSizeMake(itemWidth, itemHeight);
        _flow.minimumLineSpacing = self.MiddleHorizonMargin;
        _flow.minimumInteritemSpacing = self.MiddleVerticalMargin;
        _flow.sectionInset = UIEdgeInsetsMake(self.TopMargin, self.RightLeftMargin, self.BottomMargin, self.RightLeftMargin);
        
    }
    return _flow;
}


#pragma mark ============================================== 代理函数

static NSString *identifier_CollectionView = @"identifierForCollectionView";

#pragma mark ================= collectionView - datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.canEdit) {
#pragma mark ============================================== 可编辑状态
        
        if (self.dataArr.count >= self.maxImgCount) {
            return self.dataArr.count;
        }else{
            return self.dataArr.count + 1;
        }
        
    }else{
#pragma mark ============================================== 不可编辑
        return self.dataArr.count;
        
    }
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak typeof(self)WS = self;
    
    YtcSimpleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_CollectionView forIndexPath:indexPath];
    
    
    if (self.canEdit) {
        
#pragma mark ============================================== 可编辑状态

        if (self.dataArr.count >= self.maxImgCount) {
            
            // 取值赋值即可
            id objc = self.dataArr[indexPath.row];
            [cell ConfigImg:objc Type:viewType_imgV IsDelete:NO Index:indexPath];
            
        }else{
            if (indexPath.row == self.dataArr.count) {
                
                // 最后一个按钮, 设置添加按钮
                [cell ConfigImg:nil Type:viewType_btn IsDelete:YES Index:indexPath];
                
                cell.addBtnCB = ^(NSInteger idx) {
                    WS.AddClickCB();
                };
                
            }else{
                // 正常赋值
                id objc = self.dataArr[indexPath.row];
                [cell ConfigImg:objc Type:viewType_imgV IsDelete:NO Index:indexPath];
                
            }
            
        }
        
        cell.imgClickCB = ^(NSInteger idx) {
            if (WS.ImgClickCB) {
                WS.ImgClickCB(idx);
            }
        };
        
        cell.delBtnCB = ^(NSInteger idx) {
            if (WS.DeleteClickCB) {
                WS.DeleteClickCB(idx);
            }
        };
        
    }else{
#pragma mark ============================================== 不可编辑
        
        // 取值赋值即可
        id objc = self.dataArr[indexPath.row];
        [cell ConfigImg:objc Type:viewType_imgV IsDelete:YES Index:indexPath];
        cell.imgClickCB = ^(NSInteger idx) {
            if (WS.ImgClickCB) {
                WS.ImgClickCB(idx);
            }
        };
        
    }
    
    
   
    
    return cell;
}


#pragma mark ================= collectionView - delegate





@end
