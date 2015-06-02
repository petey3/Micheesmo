//
//  Deck.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "Deck.h"

//Private Interface
@interface Deck()

//Properties
@property (strong, nonatomic) NSMutableArray* cards; //of cards

@end

@implementation Deck

//Lazy init of cards
- (NSMutableArray*)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card*)card atTop:(BOOL)atTop
{
    if(atTop) [self.cards insertObject:card atIndex:0];
    else [self.cards addObject:card];
}

-(void)addCard:(Card*)card
{
    [self addCard:card atTop:NO];
}

-(Card*)drawRandomCard
{
    Card* randomCard = nil;
    
    if([self.cards count])
    {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
