//
//  ZAttributedStringPrivate.h
//  FontLabel
//
//  Created by Kevin Ballard on 9/23/09.
//  Copyright 2009 Zynga Game Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAttributedString.h"

@interface ZAttributeRun : NSObject <NSCopying, NSCoding> {
    NSUInteger _index;
    NSMutableDictionary *_attributes;
}
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, readonly) NSMutableDictionary *attributes;
+ (instancetype)attributeRunWithIndex:(NSUInteger)idx attributes:(NSDictionary *)attrs;
- (instancetype)initWithIndex:(NSUInteger)idx attributes:(NSDictionary *)attrs NS_DESIGNATED_INITIALIZER;
@end

@interface ZAttributedString (ZAttributedStringPrivate)
@property (nonatomic, readonly) NSArray *attributes;
@end
