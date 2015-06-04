//
//  MatchBox.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/3/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "MatchBox.h"

@interface MatchBox()

@property (strong, nonatomic, readwrite) NSMutableArray* chosenCards;
@property (nonatomic, readwrite) NSInteger targetCount;
@end


@implementation MatchBox

//initWithCount
- (instancetype) initWithCount:(NSInteger)count
{
    self = [super init];
    
    if(self)
    {
        self.chosenCards = [NSMutableArray arrayWithCapacity:count];
        self.targetCount = count;
        //for good measure
        [self clear];
    }
    return self;
}

//addChosenCard
- (BOOL) addChosenCard:(Card *)card
{
    //make sure its safe to add
    if(self.chosenCards.count < self.targetCount)
    {
        [self.chosenCards addObject:card];
        return YES;
    }
    return NO;
}

//removeChosenCard
- (BOOL) removeChosenCard:(Card *)card
{
    for(int index=0; index < self.chosenCards.count; index++)
    {
        if(card == self.chosenCards[index])
        {
            [self.chosenCards removeObjectAtIndex:index]; //sets nil?
            return YES;
        }
    }
    
    return NO;
}

//clear
- (void) clear
{
    self.chosenCards = [NSMutableArray arrayWithCapacity:self.targetCount];
    self.isMatchFull = NO;
    self.matchPoints = 0;}

@end
