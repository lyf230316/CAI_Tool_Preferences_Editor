//
//  ContentController.m
//  CTPE
//
//  Created by lyf on 2023/12/8.
//

#import "ContentController.h"

@interface ContentController ()

@property (weak) IBOutlet NSView *container;

@end

@implementation ContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(EditorController *)editorController {
    NSView *v = self.container.subviews.firstObject;
    if (v) {
        EditorController *ec = (EditorController *)v.nextResponder;
        if (ec && [ec isKindOfClass:[EditorController class]]) {
            return ec;
        }
    }
    return nil;
}

- (IBAction)reload:(id)sender {
    EditorController *ec = [self editorController];
    if (ec) {
        [ec reload:sender];
    }
}
- (IBAction)save:(id)sender {
    EditorController *ec = [self editorController];
    if (ec) {
        [ec save:sender];
    }
}

@end
