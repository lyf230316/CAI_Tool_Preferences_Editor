//
//  ContentController.h
//  CTPE
//
//  Created by lyf on 2023/12/8.
//

#import <Cocoa/Cocoa.h>
#import "EditorController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentController : NSViewController

-(EditorController *)editorController;

@end

NS_ASSUME_NONNULL_END
