//
//  LinkListViewController.m
//  Review
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "LinkListViewController.h"
#import "LinkListVM.h"

@interface LinkListViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loopLogButton;
@property (weak, nonatomic) IBOutlet UIButton * recursiveLogButton;
@property (weak, nonatomic) IBOutlet UIButton *loopReverseButton;
@property (weak, nonatomic) IBOutlet UIButton * recursiveReverseButton;

@property (strong, nonatomic, readonly) LinkListVM *vm;

@end

@implementation LinkListViewController
@synthesize vm = _vm;

#pragma mark - 属性方法
- (LinkListVM *)vm {
    if (_vm == nil) {
        _vm = [[LinkListVM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}

- (void)bindVM {
    self.title = @"单向链表";
    self.loopLogButton.rac_command = self.vm.loopLogCommand;
    self.recursiveLogButton.rac_command = self.vm.recursiveLogCommand;
    self.loopReverseButton.rac_command = self.vm.loopReverseCommand;
    self.recursiveReverseButton.rac_command = self.vm.recursiveReverseCommand;
}

@end
