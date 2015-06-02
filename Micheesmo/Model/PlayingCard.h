//
//  PlayingCard.h
//  Micheesmo
//
//  PlayingCard:
//  Model for a "standard" playing card (suit and rank)
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

//Properties
@property (strong, nonatomic) NSString* suit; //single char symbol
@property (nonatomic) NSUInteger rank; //0 not set, 1-13 valid

//Class Methods
///@return an array of strings of the valid pc suits
+ (NSArray*) validSuits;

///@return the hightest playing card rank
+ (NSUInteger) maxRank;

@end
