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
@property (strong, nonatomic) MatchBox* matchBox; //holds match info
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

//matchbox
- (MatchBox*) matchBox
{
    if(!_matchBox) _matchBox = [[MatchBox alloc] initWithCount:2]; //TODO: replace with matchMode lazy getter
    return _matchBox;
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
    _matchBox = nil; //we make a new one when we get mode #
    
    //NOTE: this expects a new, FULL deck
    //TODO: reinforce that so we dont get passed bad decks
    for(int c=0; c < count; c++)
    {
        Card* card = [deck drawRandomCard];
        //we can't have any nil cards, so check them
        if(card) { [self.cards addObject:card]; }
        else {return NO;}
    }
    self.gameStarted = NO; //only start once first card is selected
    self.score = 0; //should do this by default
    return YES;
}

//chooseCardAtIndex
- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self getCardAtIndex:index];
    
    //We delay clearing until they are choosing a card on a full MatchBox
    if(self.matchBox.isMatchFull)
    {
        //Set the cards to chosen or matched based on score
        for(Card* card in self.matchBox.chosenCards)
        {
            BOOL state = self.matchBox.matchPoints > 0 ? YES : NO;
            card.chosen = state;
            card.matched = state;
        }
        
        for(Card* card in self.cards)
        {
            if(!card.isMatched) card.chosen = NO;
        }
        
        [self.matchBox clear];
    }
    
    if(!card.isMatched) //ignore matched cards
    {
        //toggle already chosen cards
        if(card.isChosen)
        {
            card.chosen = NO;
            [self.matchBox removeChosenCard:card];
        }
        else
        {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            [self.matchBox addChosenCard:card];
        }
    }
    
    [self updateMatchBox];
    
    //We then check if its full again after updating the MatchBox
    if(self.matchBox.isMatchFull)
    {
        self.score += self.matchBox.matchPoints;
    }
    
    /*
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
                        card.matched = YES;
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
    }*/
    
}

/*!
 updateMatchBox
 @discussion pass over the MatchBox contents and update the score it holds onto
 @return void
 */
- (void) updateMatchBox
{
    //First we check if its ready for a score or not
    if(self.matchBox.chosenCards.count == self.matchBox.targetCount)
    {
        self.matchBox.isMatchFull = YES;
    }
    
    //Once its full, we can get to scoring
    if(self.matchBox.isMatchFull)
    {
        /* Depending on how we pass over the cards, we will get
         different scores. So we pass over them all ways and keep
         the highest */
        NSInteger maxScore = 0;
        for(Card* compareCard in self.matchBox.chosenCards)
        {
            NSInteger possibleScore = 0; //score for this combination
            //Match against each other card
            for(Card* otherCard in self.matchBox.chosenCards)
            {
                if(compareCard != otherCard) //avoid matching self
                {
                    int matchScore = [compareCard match:otherCard];
                    if(matchScore)
                    {
                        possibleScore += matchScore * MATCH_BONUS;
                    }
                    //we penalize later if we need to
                }
                //if this possible score is higher than current max, set it
                maxScore = possibleScore > maxScore ? possibleScore : maxScore;
            }
        }
        
        //The score is set elsewere, matchBox just holds onto it for now
        self.matchBox.matchPoints = maxScore > 0 ? maxScore : (-1 * MISMATCH_PENTALTY);
    }
}

//getCardAtIndex
- (Card*) getCardAtIndex:(NSUInteger)index
{
    BOOL inBounds = index < [self.cards count];
    return inBounds ? self.cards[index] : nil;
}

//setGameMode
- (void) setGameMode:(NSInteger)count
{
    //we let them give us any number but we know
    //(for now) we just want 2 or 3. So "round" it
    _matchMode = (count <= 2) ? 2 : 3;
    self.matchBox = [[MatchBox alloc] initWithCount:_matchMode];
}

//getLatestMatchState
- (MatchBox*) getLatestMatchState
{
    [self updateMatchBox];
    return self.matchBox;
}

@end
