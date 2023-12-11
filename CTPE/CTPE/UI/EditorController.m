//
//  EditorController.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "EditorController.h"
#import <LNPropertyListEditor/LNPropertyListEditor.h>
#import "NSView+Layout.h"

NSString * SelectedPreferenceFile = @"SelectedPreferenceFile";

@interface EditorController () <LNPropertyListEditorDelegate, LNPropertyListEditorDataTransformer>
@property(nonatomic, strong)PreferenceFile *pf;
@property(nonatomic, strong)LNPropertyListEditor *plistEditor;
@end

@implementation EditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plistEditor = [[LNPropertyListEditor alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.plistEditor];
    [self.plistEditor fullInSuperView];
    _plistEditor.delegate = self;
    _plistEditor.dataTransformer = self;
    _plistEditor.allowsColumnSorting = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifySelectedPreferenceFile:) name:SelectedPreferenceFile object:nil];
}

- (void)notifySelectedPreferenceFile:(NSNotification *)notify {
    PreferenceFile *pf = notify.object;
    self.pf = pf;
    [self reload:self];
}

- (void)reload:(id)sender {
    if (self.pf) {
        NSData * data = [NSData dataWithContentsOfFile:self.pf.path];
        if (data) {
            id obj = [NSPropertyListSerialization propertyListWithData:data options:0 format:nil error:NULL];
            self.plistEditor.delegate = nil;
            self.plistEditor.propertyListObject = obj;
            self.plistEditor.delegate = self;
        }
    }
}

- (void)save:(id)sender {
    if (self.pf) {
        NSError * error = nil;
        NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.plistEditor.propertyListObject format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        if (data) {
            [data writeToFile:self.pf.path atomically:YES];
        }
    }
}


#pragma mark LNPropertyListEditorDelegate

//- (BOOL)propertyListEditor:(LNPropertyListEditor *)editor canEditValueOfNode:(LNPropertyListNode*)node
//{
//    return NO;
//}

- (void)propertyListEditor:(LNPropertyListEditor *)editor didChangeNode:(LNPropertyListNode *)node changeType:(LNPropertyListNodeChangeType)changeType previousKey:(NSString *)previousKey
{
    switch(changeType)
    {
        case LNPropertyListNodeChangeTypeInsert:
            NSLog(@"🎉 Inserted %@", node);
            break;
        case LNPropertyListNodeChangeTypeDelete:
            NSLog(@"🗑 Deleted %@", node);
            break;
        case LNPropertyListNodeChangeTypeMove:
            NSLog(@"➡️ Moved %@", node);
            break;
        case LNPropertyListNodeChangeTypeUpdate:
            NSLog(@"🔄 Updated %@", node);
            break;
    }
}

#pragma mark LNPropertyListEditorDataTransformer

//- (nullable id)propertyListEditor:(LNPropertyListEditor *)editor displayValueForNode:(LNPropertyListNode*)node
//{
//    if(node.type == LNPropertyListNodeTypeData)
//    {
//        return @"Test";
//    }
//
//    return nil;
//}
//
//- (nullable id)propertyListEditor:(LNPropertyListEditor *)editor storageValueForNode:(LNPropertyListNode*)node displayValue:(id)displayValue
//{
//    if(node.type == LNPropertyListNodeTypeData)
//    {
//        return [displayValue dataUsingEncoding:NSUTF8StringEncoding];
//    }
//
//    return nil;
//}

@end
