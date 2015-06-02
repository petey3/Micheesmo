//
//  PlayingCardDeck.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype) init
{
    self = [super init];
    
    if(self)
    {
        //for every suit..
        for (NSString* suit in [PlayingCard validSuits])
        {
            //make a card for each rank (exclude "?")
            for (NSUInteger rank = 1; rank < [PlayingCard maxRank]; rank++)
            {
                PlayingCard* card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
