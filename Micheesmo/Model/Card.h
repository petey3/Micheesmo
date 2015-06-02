//
//  Card.h
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

//Properties
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

//Methods

/*! Match
 @discussion How good of a "match" is the given card to this card?
 @return quality of match: 0 is no match, >0 is increasingly better
*/
- (int) match:(Card *)card;

@end
