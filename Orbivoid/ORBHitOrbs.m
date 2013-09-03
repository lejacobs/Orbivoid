//
//  ORBHitOrbs.m
//  Orbivoid
//
//  Created by Joachim Bengtsson on 2013-09-03.
//  Copyright (c) 2013 Neto. All rights reserved.
//

#import "ORBHitOrbs.h"
#import "ORBCharacterNode.h"

@implementation ORBHitOrbs
{
    int _score;
}
- (void)didMoveToView:(SKView *)view
{
    [self performSelector:@selector(spawnEnemy) withObject:nil afterDelay:1.0];
}

- (void)spawnEnemy
{
    [super spawnEnemy];
    
    // Next spawn
    [self runAction:[SKAction sequence:@[
        [SKAction waitForDuration:1],
        [SKAction performSelector:@selector(spawnEnemy) onTarget:self],
    ]]];
}

+ (NSString*)modeName
{
    return @"Hit Orbs";
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    _score += 1;
    
    [self.enemies removeObject:contact.bodyB.node];
    [contact.bodyB.node removeFromParent];
    [(id)contact.bodyB.node didLeaveParent];
    [self updateScoreLabel];
}

- (void)updateScoreLabel
{
    [super updateScoreLabel];
    self.scoreLabel.text = [NSString stringWithFormat:@"%02d", _score];
}

@end
