//
//  QuickSortViewController.m
//  Review
//
//  Created by 綦帅鹏 on 2019/7/5.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "QuickSortViewController.h"
#import "CoordinateView.h"
#import "Masonry.h"
#import "QuickSortVM.h"

@interface QuickSortViewController ()

@property (strong, nonatomic, readonly) QuickSortVM *vm;
@property (strong, nonatomic, readonly) NSMutableArray *labels;

@property (weak, nonatomic) CoordinateView *coordinateV;

@property (weak, nonatomic) IBOutlet UIButton *resetB;
@property (weak, nonatomic) IBOutlet UIButton *nextB;
@property (weak, nonatomic) IBOutlet UIButton *playB;

@end

@implementation QuickSortViewController
@synthesize vm = _vm;
@synthesize labels = _labels;


#pragma mark - 属性方法
- (QuickSortVM *)vm {
    if (_vm == nil) {
        _vm = [QuickSortVM vmWithNumberCount:8 maxNumber:8];
    }
    
    return _vm;
}
- (NSMutableArray *)labels {
    if (_labels == nil) {
        _labels = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < self.vm.numberCount; i++) {
            int random = arc4random()%self.vm.maxNumber + 1;
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%i", random];
            [self.view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(@(CGSizeMake(20.0f, 20.0f)));
                make.centerX.equalTo(self.coordinateV.mas_left);
                make.centerY.equalTo(self.coordinateV.mas_top);
            }];
            [self.labels addObject:label];
            NSLog(@"%i: %i", i + 1, random);
        }
    }
    
    return _labels;
}


#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindVM];
    
    int cArr[10] = {10, 5, 3, 6, 8, 8, 6, 8, 8, 5};
    quickSortC(cArr, 0, 9);
    printCArray(cArr, 10);
    
    NSMutableArray *ocArr = [NSMutableArray arrayWithObjects:@10, @5, @3, @6, @8, @8, @6, @8, @8, @5, nil];
    [self.vm quickSortOC:ocArr left:0 right:ocArr.count - 1];
    NSLog(@"%@", ocArr);

    ocArr = [NSMutableArray arrayWithObjects:@10, @5, @3, @6, @8, @8, @6, @8, @8, @5, nil];
    [self.vm quickSortSwift:ocArr left:0 right:ocArr.count - 1];
    NSLog(@"%@", ocArr);
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = [self.labels objectAtIndex:i];
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.coordinateV.mas_left).offset([self.coordinateV xFormValueX:[label.text intValue]]);
            make.centerY.equalTo(self.coordinateV.mas_top).offset([self.coordinateV yFormValueY:i + 1]);
        }];
    }
}


#pragma mark - 自定义方法
- (void)settingUI {
    CoordinateView *view = [CoordinateView coordinateWithMaxX:self.vm.maxNumber maxY:self.vm.numberCount];
    [self.view addSubview:view];
    self.coordinateV = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(8.0);
        } else {
            make.left.equalTo(self.view).offset(8.0);
        }
        if (@available(iOS 11.0, *)) {
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-8.0);
        } else {
            make.right.equalTo(self.view).offset(-8.0);
        }
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(8.0);
        make.bottom.equalTo(self.resetB.mas_top).offset(-8.0);
    }];
    
    [self labels];
}
- (void)bindVM {
    @weakify(self)
    self.resetB.rac_command = self.vm.resetCommand;
    [self.vm.resetCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.vm.left = 0;
        self.vm.right = self.vm.numberCount - 1;
        [self.view setNeedsUpdateConstraints];
        for (UILabel *label in self.labels) {
            int random = arc4random()%self.vm.maxNumber + 1;
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                label.text = [NSString stringWithFormat:@"%i", random];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            NSLog(@"%zi: %i", [self.labels indexOfObject:label], random);
        }
    }];
    
    self.nextB.rac_command = self.vm.nextCommand;
    [self.vm.nextCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self animationWithAllSteps:NO];
    }];
    
    self.playB.rac_command = self.vm.playCommand;
    [self.vm.playCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self animationWithAllSteps:YES];
    }];
}
- (void)animationWithAllSteps:(BOOL)all {
    if (self.vm.right <= self.vm.left && self.vm.numberCount - 1 < self.vm.right - self.vm.left) {
        self.vm.animating = NO;
        self.vm.animateingAll = NO;
        return;
    }
    
    if (!self.vm.animateingAll) {
        self.vm.animateingAll = all;
    }
    self.vm.animating = YES;
    UILabel *label1 = self.labels[self.vm.left];
    UILabel *label2 = self.labels[self.vm.right];
    if (self.vm.large) {
        if ([label2.text intValue] >= [label1.text intValue]) {
            self.vm.right--;
            if (all && self.vm.left < self.vm.right) {
                [self animationWithAllSteps:all];
            } else {
                self.vm.animating = NO;
                self.vm.animateingAll = NO;
            }
        } else {
            [self.labels exchangeObjectAtIndex:self.vm.left withObjectAtIndex:self.vm.right];
            [UIView animateWithDuration:0.3 animations:^{
                [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.coordinateV).offset([self.coordinateV yFormValueY:self.vm.right + 1]);
                }];
                [label2 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.coordinateV).offset([self.coordinateV yFormValueY:self.vm.left + 1]);
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.vm.index = self.vm.right;
                self.vm.right--;
                self.vm.large = !self.vm.large;
                if (all && self.vm.left < self.vm.right) {
                    [self animationWithAllSteps:all];
                } else {
                    self.vm.animating = NO;
                    self.vm.animateingAll = NO;
                }
            }];
        }
    } else {
        if ([label1.text intValue] <= [label1.text intValue]) {
            self.vm.left++;
            if (all && self.vm.left < self.vm.right) {
                [self animationWithAllSteps:all];
            } else {
                self.vm.animating = NO;
                self.vm.animateingAll = NO;
            }
        } else {
            [self.labels exchangeObjectAtIndex:self.vm.left withObjectAtIndex:self.vm.right];
            [UIView animateWithDuration:0.3 animations:^{
                [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.coordinateV).offset([self.coordinateV yFormValueY:self.vm.right + 1]);
                }];
                [label2 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.coordinateV).offset([self.coordinateV yFormValueY:self.vm.left + 1]);
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.vm.index = self.vm.left;
                self.vm.large = !self.vm.large;
                
                if (all && self.vm.left < self.vm.right) {
                    [self animationWithAllSteps:all];
                } else {
                    self.vm.animating = NO;
                    self.vm.animateingAll = NO;
                }
            }];
        }
    }
}

@end
