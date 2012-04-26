//
//  Ring.h
//  TowerOfHanoi
//
//  Created by Kauserali on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "Stack.h"

@interface Ring : CCSprite {
    Stack *stack;
    CCSprite *tower;
    int weight;
}

@property (nonatomic, assign) Stack *stack;
@property (nonatomic, assign) CCSprite *tower;
@property (nonatomic, assign) int weight;
@end
