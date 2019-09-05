//
//  GCDBasicViewController.m
//  Review
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "GCDBasicViewController.h"
#import "GCDBasicVM.h"
#import "MBProgressHUD.h"
#import "Services.h"
#import "LoadingClass.h"

@interface GCDBasicViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@property (strong, nonatomic, readonly) GCDBasicVM *vm;

@end

@implementation GCDBasicViewController
@synthesize vm = _vm;

- (GCDBasicVM *)vm {
    if (_vm == nil) {
        _vm = [[GCDBasicVM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}

- (void)bindVM {
    @weakify(self);
    self.title = self.vm.title;
    RAC(self.vm, image) = RACObserve(self.imageView, image);
    
    self.removeButton.rac_command = self.vm.buttonRCommand;
    [self.vm.buttonRCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.imageView.image = nil;
    }];

    self.loadButton.rac_command = self.vm.buttonLCommand;
    [self.vm.buttonLCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [LoadingClass loadingToView:self.view];
        dispatch_queue_t queue = dispatch_queue_create("ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:self.vm.imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
                [LoadingClass hideFromView:self.view];
            });
        });
    }];
}

@end
