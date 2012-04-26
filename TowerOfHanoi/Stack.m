//
//  Stack.m
//  TowerOfHanoi
//
//  Created by Kauserali on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (id) init {
    self = [super init];
    if(self) {
        array = [[[NSMutableArray alloc] init] retain];
    }
    return self;
}

- (void) push: (id) element {
    if (element != nil) {
        [array addObject:element];
    }
}

- (id) pop {
    if ([array count] > 0) {
        id object =  [array objectAtIndex:[array count] - 1];
        [array removeObjectAtIndex:[array count] - 1];
        return object;   
    }
    return nil;
}

- (id) peek {
    if ([array count] > 0) {
        id object =  [array objectAtIndex:[array count] - 1];
        return object;
    }
    return nil;
}

- (void) dealloc {
    [super dealloc];
    [array release];
}
@end
