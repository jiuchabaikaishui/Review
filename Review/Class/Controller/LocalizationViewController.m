//
//  LocalizationViewController.m
//  Review
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "LocalizationViewController.h"

@interface LocalizationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LocalizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = [[NSBundle mainBundle] localizedStringForKey:@"LocalizationTitle" value:@"" table:nil];
    
//    self.label.text = Localized(@"LocalizationTitle");
}

@end
