//
//  DetailViewController.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "DetailViewController.h"
#import <objc/runtime.h>
#import "SampleBaseViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}
- (void)settingUi
{
    if (self.model) {
        self.title = self.model.title;
        self.textView.editable = NO;
        self.textView.text = self.model.explain;
    }
}
- (IBAction)sampleAction:(UIButton *)sender {
    if (self.model.sampleClass) {
        Class class = NSClassFromString(self.model.sampleClass);
        UIViewController *nextCtr = [[class alloc] init];
        if ([nextCtr respondsToSelector:@selector(model)]) {
            [nextCtr setValue:self.model forKey:@"model"];
        }
        [self.navigationController pushViewController:nextCtr animated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该技能没有演示示例！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//- (BOOL)class:(Class)class haveTheProperty:(NSString *)propertyName
//{
//    unsigned int count = 0;
//    objc_property_t *propertys = class_copyPropertyList(class, &count);
//    for (int index = 0; index < count; index++) {
//        NSString *name = [NSString stringWithUTF8String:property_getName(propertys[index])];
//        if ([name isEqualToString:propertyName]) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}

@end
