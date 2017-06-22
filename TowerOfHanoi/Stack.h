//
//  Stack.h
//  TowerOfHanoi
//
//  Created by Kauserali on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
    NSMutableArray *array;
}
- (void) push: (id) element;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) id pop;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) id peek;
@end
