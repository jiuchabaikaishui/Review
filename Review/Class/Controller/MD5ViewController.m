//
//  MD5ViewController.m
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "MD5ViewController.h"
#import "MD5VM.h"

@interface MD5ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button16;
@property (weak, nonatomic) IBOutlet UIButton *button32;
@property (strong, nonatomic, readonly) MD5VM *vm;

@end

@implementation MD5ViewController
@synthesize vm = _vm;

- (MD5VM *)vm {
    if (_vm == nil) {
        _vm = [[MD5VM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    self.button16.rac_command = self.vm.button16Command;
    [self.vm.button16Command.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.textView.text = [self.vm md5_16:self.textField.text upperCase:NO];
    }];
    self.button32.rac_command = self.vm.button32Command;
    [self.vm.button32Command.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.textView.text = [self.vm md5_32:self.textField.text upperCase:NO];
    }];
}

@end
