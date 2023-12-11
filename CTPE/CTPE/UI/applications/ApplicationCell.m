//
//  ApplicationCell.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "ApplicationCell.h"
#import "PreferenceFile.h"
#import "NSView+Layout.h"

@interface ApplicationCell ()

@property(nonatomic, strong)NSTextField *tf;

@end

@implementation ApplicationCell

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.tf = [[NSTextField alloc]init];
        [self addSubview:self.tf];
        [self.tf cellCenter];
        self.tf.editable = NO;
        self.tf.bezeled = NO;
        self.tf.drawsBackground = NO;
    }
    return self;
}

- (void)setObjectValue:(id)objectValue {
    [super setObjectValue:objectValue];
    PreferenceFile *pf = objectValue;
    if ([pf isKindOfClass:[PreferenceFile class]]) {
        self.tf.stringValue = pf.name;
    }
}

@end
