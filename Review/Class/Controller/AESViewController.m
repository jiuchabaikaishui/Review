//
//  AESViewController.m
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "AESViewController.h"
#import "AESVM.h"

@interface AESViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonE;
@property (weak, nonatomic) IBOutlet UIButton *buttonD;
@property (strong, nonatomic, readonly) AESVM *vm;

@end

@implementation AESViewController
@synthesize vm = _vm;

- (AESVM *)vm {
    if (_vm == nil) {
        _vm = [[AESVM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    self.buttonE.rac_command = self.vm.buttonECommand;
    [self.vm.buttonECommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        self.textView.text = [self.vm AESEncryptWithString:self.textField.text andKey:kAES_Key];
    }];
    self.buttonD.rac_command = self.vm.buttonDCommand;
    [self.vm.buttonDCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        self.textField.text = [self.vm AESDecryptWithString:self.textView.text andKey:kAES_Key];
    }];
}

@end
