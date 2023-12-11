//
//  ApplicationListController.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "ApplicationListController.h"
#import "PreferenceFile.h"
#import "NSView+Layout.h"
#import "ApplicationCell.h"
#import "EditorController.h"

@interface ApplicationListController ()<NSTableViewDelegate, NSTableViewDataSource>

@property(nonatomic, strong)NSArray *applications;
@property(nonatomic, strong)NSArray *tableArray;
@property(nonatomic, strong)NSTableView *tableView;

@end

@implementation ApplicationListController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSScrollView *scrollView = [[NSScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:scrollView];
    [scrollView fullInSuperView];
    self.tableView = [[NSTableView alloc]initWithFrame:CGRectZero];
    scrollView.contentView.documentView = self.tableView;
    
    NSTableColumn *column = [[NSTableColumn alloc]initWithIdentifier:@"name"];
    [self.tableView addTableColumn:column];
    [self.tableView setHeaderView:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.applications = [PreferenceFile userPreferences];
    self.tableArray = self.applications;
    [self.tableView reloadData];
}

- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    NSMutableArray *farray = [NSMutableArray array];
    if (keywords && keywords.length) {
        for (PreferenceFile *pf in self.applications) {
            if ([pf.name containsString:keywords]) {
                [farray addObject:pf];
            }
        }
    } else {
        [farray addObjectsFromArray:self.applications];
    }
    self.tableArray = [NSArray arrayWithArray:farray];
    [self.tableView reloadData];
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ApplicationCell *cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:nil];
    if (!cell) {
        cell = [[ApplicationCell alloc]initWithFrame:CGRectZero];
        cell.identifier = tableColumn.identifier;
    }
    return cell;
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.tableArray.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    PreferenceFile *pf = self.tableArray[row];
    return pf;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger sr = self.tableView.selectedRow;
    PreferenceFile *pf = nil;
    if ( 0<=sr && sr<self.tableArray.count) {
        pf = self.tableArray[sr];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SelectedPreferenceFile object:pf];
}

@end
