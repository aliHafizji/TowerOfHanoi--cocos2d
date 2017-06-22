//
//  GameScene.m
//  TowerOfHanoi
//
//  Created by Kauserali on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

#define kTower1Tag 1
#define kTower2Tag 2
#define kTower3Tag 3
#define kRing1Tag 4
#define kRing2Tag 5
#define kRing3Tag 6
#define kSpriteManagerTag 10

@implementation GameScene

+ (CCScene*) scene {
    CCScene *scene = [CCScene node];
    GameScene *gameScene = [GameScene node];
    [scene addChild:gameScene];
    return scene;
}

- (instancetype) init {
    self = [super init];

    if (self) {
        winSize = [[CCDirector sharedDirector] winSize];
        
        stack1 = [[Stack alloc] init];
        stack2 = [[Stack alloc] init];
        stack3 = [[Stack alloc] init];
        
        CCSpriteBatchNode *spriteManager = [CCSpriteBatchNode batchNodeWithFile:@"game_artifacts.png"];
        [spriteManager setTag:kSpriteManagerTag];
        [self addChild:spriteManager];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game_artifacts.plist"];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [spriteManager addChild:background];
        
        CCSprite *tower1 = [CCSprite spriteWithSpriteFrameName:@"tower.png"];
        tower1.position = ccp(winSize.width * 0.247, winSize.height * 0.596);
        [tower1 setTag:kTower1Tag];
        [spriteManager addChild:tower1];
        
        CCSprite *tower2 = [CCSprite spriteWithSpriteFrameName:@"tower.png"];
        tower2.position = ccp(winSize.width * 0.5, winSize.height * 0.596);
        [tower2 setTag:kTower2Tag];
        [spriteManager addChild:tower2];
        
        CCSprite *tower3 = [CCSprite spriteWithSpriteFrameName:@"tower.png"];
        tower3.position = ccp(winSize.width * 0.752, winSize.height * 0.596);
        [tower3 setTag:kTower3Tag];
        [spriteManager addChild:tower3];
        
        Ring *ring1 = [Ring spriteWithSpriteFrameName:@"ring_1.png"];
        [ring1 setTag:kRing1Tag];
        ring1.position = ccp(tower1.position.x, tower1.position.y - tower1.contentSize.height/2 + ring1.contentSize.height/2);
        [spriteManager addChild:ring1];
        
        Ring *ring2 = [Ring spriteWithSpriteFrameName:@"ring_2.png"];
        [ring2 setTag:kRing2Tag];
        ring2.position = ccp(tower1.position.x, ring1.position.y + ring1.contentSize.height/2 + ring2.contentSize.height/2);
        [spriteManager addChild:ring2];
        
        Ring *ring3 = [Ring spriteWithSpriteFrameName:@"ring_3.png"];
        [ring3 setTag:kRing3Tag];
        ring3.position = ccp(tower1.position.x, ring2.position.y + ring2.contentSize.height/2 + ring3.contentSize.height/2);
        [spriteManager addChild:ring3];
        
        [stack1 push:ring1];
        [stack1 push:ring2];
        [stack1 push:ring3];
        
        ring1.stack = stack1;
        ring2.stack = stack1;
        ring3.stack = stack1;
        
        ring1.tower = tower1;
        ring2.tower = tower1;
        ring3.tower = tower1;
        
        ring1.weight = 3;
        ring2.weight = 2;
        ring3.weight = 1;
        
        map = [[NSDictionary alloc] initWithObjectsAndKeys:stack1, @kTower1Tag,
                                                           stack2, @kTower2Tag,
                                                           stack3, @kTower3Tag, nil];
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void) registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

#pragma mark TouchMethods 

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    CCSpriteBatchNode *spriteManager = (CCSpriteBatchNode*) [self getChildByTag:kSpriteManagerTag];
    
    for (int tag = kRing1Tag; tag <= kRing3Tag; tag++) {
        Ring *ring = (Ring*) [spriteManager getChildByTag:tag];
        if (CGRectContainsPoint(ring.boundingBox, location)) {
            ring.position = location;
            selectedRing = ring;
            [selectedRing.stack pop];
            return YES;
        }
    }
    return NO;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if (selectedRing != nil) {
        CGPoint location = [touch locationInView:touch.view];
        location = [[CCDirector sharedDirector] convertToGL:location];
        selectedRing.position = location;
    }
}

- (void) moveToPreviousPosition:(Ring*) ring {
    Stack *originalStack = map[@(ring.tower.tag)];
    Ring *topRing = [originalStack peek];
    ring.position = ccp(ring.tower.position.x, topRing.position.y + topRing.contentSize.height/2 + ring.contentSize.height/2);
    [originalStack push:ring];
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (selectedRing != nil) {
        CGPoint location = [touch locationInView:touch.view];
        location = [[CCDirector sharedDirector] convertToGL:location];
        selectedRing.position = location;
        
        CCSpriteBatchNode *spriteManager = (CCSpriteBatchNode*) [self getChildByTag:kSpriteManagerTag];
        int flag = 0;
        for (int tag = kTower1Tag; tag <= kTower3Tag; tag++) {
            CCSprite *tower = (CCSprite*) [spriteManager getChildByTag:tag];
            if (CGRectIntersectsRect(selectedRing.boundingBox, tower.boundingBox)) {
                Stack *stack = map[@(tag)];
                Ring *ring = [stack peek];
                flag = 1;
                if (selectedRing.weight < ring.weight || ring == nil) {
                    CGFloat yPosition;
                    if (ring == nil) {
                        yPosition = tower.position.y - tower.contentSize.height/2 + selectedRing.contentSize.height/2;
                    } else {
                        yPosition = ring.position.y + ring.contentSize.height/2 + selectedRing.contentSize.height/2;
                    }
                    selectedRing.position = ccp(tower.position.x, yPosition);
                    selectedRing.tower = tower;
                    selectedRing.stack = stack;
                    [stack push:selectedRing];
                } else {
                    flag = 0;
                }
            }
        }
        
        if (flag == 0) {
            [self moveToPreviousPosition:selectedRing];
        }
        selectedRing = nil;
    }
}

- (void) dealloc {
    [super dealloc];
    [stack1 release];
    [stack2 release];
    [stack3 release];
}
@end
