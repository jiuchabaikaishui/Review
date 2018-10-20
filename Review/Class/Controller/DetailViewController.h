//
//  DetailViewController.h
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewModel.h"
#import "DetailVM.h"

@interface DetailViewController : UIViewController

@property (strong,nonatomic) ReviewModel *model;
@property (nonatomic, strong) DetailVM *vm;

@end
