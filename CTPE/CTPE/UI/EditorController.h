//
//  EditorController.h
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import <Cocoa/Cocoa.h>
#import "PreferenceFile.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString * SelectedPreferenceFile;

@interface EditorController : NSViewController

-(void)reload:(id)sender;
-(void)save:(id)sender;

@end

NS_ASSUME_NONNULL_END
