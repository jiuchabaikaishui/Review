//
//  LocalizationViewController.m
//  Review
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "LocalizationViewController.h"

@interface LocalizationViewController ()<UISearchControllerDelegate, UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *search;

@end

@implementation LocalizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchController *search= [[UISearchController alloc] initWithSearchResultsController:nil];
    search.delegate = self;
    search.searchResultsUpdater = self;
    self.tableView.tableHeaderView = search.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.search = search;
    
    self.label.text = [[NSBundle mainBundle] localizedStringForKey:@"LocalizationTitle" value:@"" table:nil];
    
//    self.label.text = Localized(@"LocalizationTitle");
}

#pragma mark - <UISearchControllerDelegate>代理方法


#pragma mark - <UISearchResultsUpdating>代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

@end
