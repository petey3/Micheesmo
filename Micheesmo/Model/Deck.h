//
//  Deck.h
//  Micheesmo
//
//  Deck:
//  A model for storing many cards. Just like a card deck - Woah!
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

//Properties

//Instance Methods
/*! addCard atTop
 @discussion adds a card to the deck (must specify if its at the top or not)
 @return void
 */
- (void) addCard:(Card*)card atTop:(BOOL)atTop;

///addCard with atTop always set to NO
- (void) addCard:(Card*)card;

/*!
 drawRandomCard
 @discussion draws a random card from the deck (destructive)
 @return Card*
 */
- (Card*)drawRandomCard;

@end
