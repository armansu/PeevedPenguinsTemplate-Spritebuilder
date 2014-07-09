//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Arman Suleimenov on 7/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    CCPhysicsNode * _physicsNode;
    CCNode * _catapultArm;
    CCNode * _levelNode;
    CCNode * _contentNode;
}

- (void) retry {
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

- (void) didLoadFromCCB {
    self.userInteractionEnabled = YES;
    
    CCNode * level = [CCBReader load:@"Levels/Level1"];
    [_levelNode addChild:level];
    
    _physicsNode.debugDraw = YES;
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self launchPenguin];
}

- (void) launchPenguin {
    CCNode * penguin = [CCBReader load:@"Penguin"];
    penguin.position = _catapultArm.position;
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 4000);
    [penguin.physicsBody applyForce:force];
    
    self.position = ccp(0, 0);
    CCActionFollow * follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}

@end
