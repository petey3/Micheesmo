//
//  PlayingCard.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "PlayingCard.h"



@implementation PlayingCard

- (NSString*) contents
{
    //TODO: figure out why it wants to cast as UL
    return [NSString stringWithFormat:@"%@%@", [PlayingCard rankStrings][self.rank], self.suit];
}

@synthesize suit = _suit;
//Class Methods
+ (NSArray*) validSuits {return @[@"♥️",@"♦️",@"♣️",@"♠️"]; } //emoji keyboard!

+ (NSArray*) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {return [[self rankStrings] count]-1;}

//Instance Methods
- (void) setSuit:(NSString*)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString*) suit { return _suit ? _suit : @"?"; }

- (void) setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
