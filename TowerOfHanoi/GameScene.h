//
//  GameScene.h
//  TowerOfHanoi
//
//  Created by Kauserali on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "CCLayer.h"
#import "Stack.h"
#import "Ring.h"

@interface GameScene : CCLayer {
    CGSize winSize;
    Stack *stack1, *stack2, *stack3;
    Ring *selectedRing;
    NSDictionary *map; //This is used to keep a mapping between the tower and the corresponding stack
}
+ (CCScene*) scene;
@end
