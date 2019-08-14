//
//  RSAViewController.m
//  Review
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "RSAViewController.h"
#import "RSAVM.h"

@interface RSAViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonE;
@property (weak, nonatomic) IBOutlet UIButton *buttonD;
@property (strong, nonatomic, readonly) RSAVM *vm;

@end

@implementation RSAViewController
@synthesize vm = _vm;

- (RSAVM *)vm {
    if (_vm == nil) {
        _vm = [[RSAVM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    self.buttonE.rac_command = self.vm.buttonECommand;
    [self.vm.buttonECommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
        self.textView.text = [RSAVM encryptString:self.textField.text publicKeyWithContentsOfFile:path];
    }];
    self.buttonD.rac_command = self.vm.buttonDCommand;
    [self.vm.buttonDCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
        self.textField.text = [RSAVM decryptString:self.textView.text privateKeyWithContentsOfFile:path password:@"QSP456654"];
    }];
}

@end
