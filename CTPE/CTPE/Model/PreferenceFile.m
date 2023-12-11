//
//  PreferenceFile.m
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import "PreferenceFile.h"

@implementation PreferenceFile

+ (NSArray *)userPreferences {
    NSString *dir = [NSString stringWithFormat:@"%@/Library/Preferences", NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:dir error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    NSMutableArray *res = [NSMutableArray array];
    for (NSString *file in files) {
        if ([file hasSuffix:@".plist"]) {
            PreferenceFile *pf = [[PreferenceFile alloc]init];
            pf.name = [file substringToIndex:file.length-6];
            pf.path = [NSString stringWithFormat:@"%@/%@", dir, file];
            [res addObject:pf];
        }
    }
    return res;
}

@end
