//
//  CardMatchingGame.h
//  Micheesmo
//
//  CardMatchingGame:
//  The logic that manages the game rules
//
//  Created by Eric Peterson on 6/2/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//Properties
@property (readonly, nonatomic) NSInteger score;

//Instance Methods
/*!
 initWithCardCount
 @discussion init method for the game
 @return an instance of CardMatchingGame
*/
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck*)deck;

/*!
 chooseCardAtIndex
 @discussion marks the card at index as "chosen"
 @return void
 */
- (void) chooseCardAtIndex:(NSUInteger)index;

/*!
 getCardAtIndex
 @discussion get a card from the game at the index
 @return the Card* at the given index
 */
- (Card*) getCardAtIndex:(NSUInteger)index;

/*!
 freshGame
 @discussion clear the game's score, and redeal the cards
 @return success
 */
- (BOOL) freshGame:(NSUInteger)count usingDeck:(Deck*)deck;

@end
