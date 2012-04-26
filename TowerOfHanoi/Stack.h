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
- (id) pop;
- (id) peek;
@end
