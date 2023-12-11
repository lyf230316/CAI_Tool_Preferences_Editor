//
//  NSView+Layout.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "NSView+Layout.h"

@implementation NSView (Layout)

-(void)fullInSuperView {
    NSView *container = self.superview;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.topAnchor constraintEqualToAnchor:container.topAnchor] setActive:YES];
    [[self.leftAnchor constraintEqualToAnchor:container.leftAnchor] setActive:YES];
    [[self.bottomAnchor constraintEqualToAnchor:container.bottomAnchor] setActive:YES];
    [[self.rightAnchor constraintEqualToAnchor:container.rightAnchor] setActive:YES];
}

-(void)cellCenter {
    NSView *container = self.superview;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.leftAnchor constraintEqualToAnchor:container.leftAnchor] setActive:YES];
    [[self.rightAnchor constraintEqualToAnchor:container.rightAnchor] setActive:YES];
    [[self.centerYAnchor constraintEqualToAnchor:container.centerYAnchor] setActive:YES];
}

@end
