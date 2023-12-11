//
//  LeftViewController.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "LeftViewController.h"
#import "ApplicationListController.h"

@interface LeftViewController ()<NSSearchFieldDelegate>

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSView *container;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchField.delegate = self;
    self.searchField.sendsWholeSearchString = YES;
    
    // Do view setup here.
}

#pragma mark - NSSearchFieldDelegate

- (void)controlTextDidChange:(NSNotification *)obj {
    NSLog(@"search:%@", self.searchField.stringValue);
    NSView *v = self.container.subviews.firstObject;
    if (v) {
        ApplicationListController *applistCtl = (ApplicationListController *)v.nextResponder;
        if (applistCtl && [applistCtl isKindOfClass:[ApplicationListController class]]) {
            applistCtl.keywords = self.searchField.stringValue;
        }
    }
}

@end
