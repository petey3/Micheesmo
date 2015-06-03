//
//  CardMatchingGame.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/2/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "CardMatchingGame.h"

//Private Interface
@interface CardMatchingGame()
//Properties
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray* cards; //Array of Card*
@end

@implementation CardMatchingGame

//Getcha constants here
static const int MISMATCH_PENTALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

//cards
- (NSMutableArray*) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//initWithCardCount
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        if(![self freshGame:count usingDeck:deck]) { self = nil; }
    }

    return self;
}

//freshGame
- (BOOL) freshGame:(NSUInteger)count usingDeck:(Deck *)deck
{
    //wipe the cards array, will lazy init below
    _cards = nil;
    
    //NOTE: this expects a new, FULL deck
    //TODO: reinforce that so we dont get passed bad decks
    for(int c=0; c < count; c++)
    {
        Card* card = [deck drawRandomCard];
        //we can't have any nil cards, so check them
        if(card) { [self.cards addObject:card]; }
        else {return NO;}
    }
    
    self.score = 0; //should do this by default
    return YES;
}

//chooseCardAtIndex
- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self getCardAtIndex:index];
    
    if(!card.isMatched) //ignore matched cards
    {
        if(card.isChosen) { card.chosen = NO; }
        else
        {
            //find other chosen and unmatched cards
            for(Card* otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:otherCard];
                    if(matchScore)
                    {
                        otherCard.matched = YES;
                        otherCard.chosen = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else
                    {
                        otherCard.chosen = NO;
                        self.score -= MISMATCH_PENTALTY;
                    }
                    break; //stop at 2 cards
                }
            }
            
            //We set chosen for the card @ index after
            //so that it doesn't get matched against itself
            //in the loop
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        }
    }
}

//getCardAtIndex
- (Card*) getCardAtIndex:(NSUInteger)index
{
    BOOL inBounds = index < [self.cards count];
    return inBounds ? self.cards[index] : nil;
}

@end
