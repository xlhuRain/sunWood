//
//  ViewController.h
//  sunWood
//
//  Created by xlhu_mac on 14-1-16.
//  Copyright (c) 2014年 tagux-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIImageView *modelImgView;
@property(nonatomic,strong)IBOutlet UIImageView *shaderImgView;


-(IBAction)senderData:(id)sender;

@end
