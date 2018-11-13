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
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     //队列
     //全局队列
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     
     //主队列
     queue = dispatch_get_main_queue();
     
     //串行队列
     queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
     
     //并行队列
     queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
     
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
     NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
     for (NSInteger index = 0; index < 10000; index++) {
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     [mArr addObject:[NSNumber numberWithInteger:index]];
     dispatch_semaphore_signal(semaphore);
     });
     }
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     });
     dispatch_group_t group = dispatch_group_create();
     dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     });
     */
    
    [self settingUI];
    [self bindVM];
}
- (void)settingUI
{
    
}

- (void)bindVM {
    self.title = self.vm.title;
    self.textView.text = self.vm.explain;
    self.button.rac_command = self.vm.command;
    @weakify(self);
    [self.vm.command.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.vm.sampleClass) {
            UIViewController *nextCtr = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:self.vm.sampleClass];
            [self.navigationController pushViewController:nextCtr animated:YES];
        }
        else
        {
            UIAlertController *nextCtr = [UIAlertController alertControllerWithTitle:@"提示" message:@"该技能没有演示示例！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                @strongify(self);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [nextCtr addAction:okAction];
            [self presentViewController:nextCtr animated:YES completion:nil];
        }
    }];
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
