//
//  ViewController.m
//  sunWood
//
//  Created by xlhu_mac on 14-1-16.
//  Copyright (c) 2014年 tagux-mac. All rights reserved.
//

#import "ViewController.h"

#define defAngle  10

@interface ViewController ()

@property(nonatomic,strong)CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.modelImgView.layer.anchorPoint = CGPointMake(0.5, 0);
    NSLog(@"frame %@",NSStringFromCGRect(self.modelImgView.frame));

    
    self.motionManager = [[CMMotionManager alloc] init];
    if (!self.motionManager.accelerometerAvailable) {
        NSLog(@"没有加速计");
    }
    self.motionManager.deviceMotionUpdateInterval = 0.02; // 告诉manager，更新频率是100Hz
    [self.motionManager startDeviceMotionUpdates];
//    [self.motionManager startAccelerometerUpdates];
//    [motionManager startGyroUpdates];
//    [motionManager startMagnetometerUpdates];
    
//    CMRotationRate rotationRate = motionManager.deviceMotion.rotationRate;
//    double rotationX = rotationRate.x;//X轴角速度
//    double rotationY = rotationRate.y;
//    double rotationZ = rotationRate.z;
    
//    CMAccelerometerData *newestAccel = motionManager.accelerometerData;
//    double accelerationX = newestAccel.acceleration.x;//X轴加速度
//    double accelerationY = newestAccel.acceleration.y;
//    double accelerationZ = newestAccel.acceleration.z;
//    double gravityX = motionManager.deviceMotion.gravity.x;
//    double gravityY = motionManager.deviceMotion.gravity.y;
//    double gravityZ = motionManager.deviceMotion.gravity.z;
//    double roll    = motionManager.deviceMotion.attitude.roll;
//    double pitch   = motionManager.deviceMotion.attitude.pitch;
//    double yaw     = motionManager.deviceMotion.attitude.yaw;
//    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;  //Z轴倾斜角度
//    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;//屏幕旋转角度
    
    [self.motionManager  startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        double gravityX = motion.gravity.x;
        double gravityY = motion.gravity.y;
        double gravityZ = motion.gravity.z;
        double roll    = motion.attitude.roll;
        double pitch   = motion.attitude.pitch;
        double yaw     = motion.attitude.yaw;
        
        double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;  //Z轴倾斜角度
        double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;//屏幕旋转角度


        
 
        if(roll<-0.7){
            self.modelImgView.transform = CGAffineTransformMakeRotation(M_PI/180*defAngle);
        }else if (roll>0.7){
            self.modelImgView.transform = CGAffineTransformMakeRotation(M_PI/-180*defAngle);
        }else{
            float angle = defAngle*roll/0.7;
            self.modelImgView.transform = CGAffineTransformMakeRotation(M_PI/-180*angle);
        };
        
        
    }];
}

-(IBAction)senderData:(id)sender{

    double gravityX = self.motionManager.deviceMotion.gravity.x;
    double gravityY = self.motionManager.deviceMotion.gravity.y;
    double gravityZ = self.motionManager.deviceMotion.gravity.z;
    double roll    = self.motionManager.deviceMotion.attitude.roll;
    double pitch   = self.motionManager.deviceMotion.attitude.pitch;
    double yaw     = self.motionManager.deviceMotion.attitude.yaw;
    
    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;  //Z轴倾斜角度
    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;//屏幕旋转角度
    
    NSLog(@"roll %f pintch  %f yaw %f",roll,pitch,yaw);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
