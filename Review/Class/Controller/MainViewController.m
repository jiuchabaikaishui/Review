//
//  ViewController.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "MainVM.h"
#import "CommonDefine.h"
#import "DetailVM.h"

@interface MainViewController ()

@property (nonatomic, strong) MainVM *vm;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

#pragma mark - 属性方法
- (MainVM *)vm {
    if (_vm == nil) {
        _vm = [[MainVM alloc] init];
    }
    
    return _vm;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HomeToDetail"]) {
        DetailViewController *nextCtr = (DetailViewController *)segue.destinationViewController;
        MainCellM *model = ((QSPTableViewCellVM *)[self.vm.tableViewVM rowVMWithIndexPath:[self.tableView indexPathForCell:sender]]).dataM;
        nextCtr.vm = [DetailVM detailVMWithTitle:model.title net:model.isNet explain:model.explain andSampleClass:model.sampleClass];
    }
}

#pragma mark - 自定义方法
- (void)bindVM {
    self.title = self.vm.title;
    self.tableView.vmSet(self.vm.tableViewVM);
    @weakify(self);
    [self.vm.tableViewVM.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *obj) {
        @strongify(self);
        [obj.tableView deselectRowAtIndexPath:obj.indexPath animated:YES];
        [self performSegueWithIdentifier:@"HomeToDetail" sender:[obj.tableView cellForRowAtIndexPath:obj.indexPath]];
    }];
}

@end
