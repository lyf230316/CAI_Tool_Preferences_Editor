//
//  PreferenceFile.h
//  CTPE
//
//  Created by lyf on 2023/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreferenceFile : NSObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *path;

+ (NSArray *)userPreferences;

@end

NS_ASSUME_NONNULL_END
