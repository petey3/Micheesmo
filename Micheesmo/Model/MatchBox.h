//
//  MatchBox.h
//  Micheesmo
//
//  MatchBox
//  A bundle of information the CardMatching Game
//  holds onto to represent the "current" state of matching
//  that we can hand off to the view for it do present
//  information to the user
//
//  Created by Eric Peterson on 6/3/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface MatchBox : NSObject
//Properties
//NOTE: its mutable but we dont want the size changing,
//so we make it readonly and handle insertion with a method
@property (strong, nonatomic, readonly) NSMutableArray* chosenCards; //Card*
@property (nonatomic) BOOL isMatchFull; //shorthand way to check if we have enough cards to match or not
@property (nonatomic) NSInteger matchPoints; //if the match is complete, this is how many points are awarded
@property (nonatomic, readonly) NSInteger targetCount; //the number of cards this MatchBox expects to match on

//Instance Methods
/*!
 initWithCount
 @discussion init a MatchResults object with the number of cards it expects for a match (i.e. game mode)
 @return MatchResults obj
 */
- (instancetype) initWithCount:(NSInteger)count;

/*!
 addChosenCard
 @discussion given a card, add it to the chosenCards if there is space, else it wont be added
 @return success
 */
- (BOOL) addChosenCard:(Card*) card;

/*!
 removeChosenCard
 @discussion given a card, remove it from chosenCards if it exists inside
 @return success
 */
- (BOOL) removeChosenCard:(Card*) card;

/*!
 clear
 @discussion once a matchBox has been used, clear it
 @return void
 */
-(void) clear;

@end
