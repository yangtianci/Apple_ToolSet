//
//  SceneARController.m
//  ARDemo
//
//  Created by YangTianCi on 2018/2/28.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "SceneARController.h"
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface SceneARController ()<ARSessionDelegate,ARSCNViewDelegate>

@property (nonatomic, strong) ARSCNView *MainView;
@property (nonatomic, strong) ARSession *arsession;
@property (nonatomic, strong) ARWorldTrackingConfiguration *trackConfig;

@end

@implementation SceneARController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //session
    self.arsession = [[ARSession alloc]init];
    self.arsession.delegate = self;
    
    //config
    self.trackConfig = [[ARWorldTrackingConfiguration alloc]init];
    //设置平地追踪
    self.trackConfig.planeDetection = ARPlaneDetectionHorizontal;
    //设置灯光自适应
    self.trackConfig.lightEstimationEnabled = YES;
    
    //sceneView
    self.MainView = [[ARSCNView alloc]initWithFrame:self.view.bounds];
    self.MainView.delegate = self;
    self.MainView.showsStatistics = YES;
    self.MainView.session = self.arsession;
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.MainView];
    [self.arsession runWithConfiguration:self.trackConfig];
    
}


#pragma mark ============= 旋转实现
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    if (self.style == Style_rotato) {
        
        //初始化需要旋转的节点
        SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/lamp/lamp.scn"];
        SCNNode *newNode = scene.rootNode.childNodes.firstObject;
        newNode.scale = SCNVector3Make(0.7, 0.7, 0.7);
        newNode.position = SCNVector3Make(0, -15, -15);
        for (SCNNode *node in newNode.childNodes) {
            node.scale = SCNVector3Make(0.7, 0.7, 0.7);
            node.position = SCNVector3Make(0, -15, -15);
        }
     
        //初始化空节点
        SCNNode *emptyNode = [[SCNNode alloc]init];
        //相机位置
        emptyNode.position = self.MainView.scene.rootNode.position;
        [self.MainView.scene.rootNode addChildNode:emptyNode];
        
        [emptyNode addChildNode:newNode];
        
        //布局完成, 开始动画
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"rotation"];
        animation.duration = 10;
        animation.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0, 1, 0, M_PI * 2)];
        animation.repeatCount = FLT_MAX;
        [emptyNode addAnimation:animation forKey:@"RRRRRRRotation"];
        
    }
    
}





#pragma mark ============= SCN 代理
//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor{
//}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    
    if (self.style != Style_planeHoriz) {
        return;
    }
    
    /**
     //2.创建一个3D物体模型    （系统捕捉到的平地是一个不规则大小的长方形，这里笔者将其变成一个长方形，并且是否对平地做了一个缩放效果）
     //参数分别是长宽高和圆角
     SCNBox *plane = [SCNBox boxWithWidth:planeAnchor.extent.x*0.3 height:0 length:planeAnchor.extent.x*0.3 chamferRadius:0];
     //3.使用Material渲染3D模型（默认模型是白色的，这里笔者改成红色）
     plane.firstMaterial.diffuse.contents = [UIColor redColor];
     
     //4.创建一个基于3D物体模型的节点
     SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
     //5.设置节点的位置为捕捉到的平地的锚点的中心位置  SceneKit框架中节点的位置position是一个基于3D坐标系的矢量坐标SCNVector3Make
     planeNode.position =SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
     
     //self.planeNode = planeNode;
     [node addChildNode:planeNode];
     
     */
    
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        NSLog(@"此锚点为平地");
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor*)anchor;
        SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/vase/vase.scn"];
        SCNNode *airplaneNode = scene.rootNode.childNodes[0];
        airplaneNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        NSLog(@"%lf---%lf---%lf",airplaneNode.position.x,airplaneNode.position.y,airplaneNode.position.z);
        [node addChildNode:airplaneNode];
    }
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor;{
    
}

#pragma mark ============= Session 代理

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame{
    
}

- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors{
    
}

- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors{
    
}

- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor*>*)anchors{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Scene 内存警告");
}



@end
