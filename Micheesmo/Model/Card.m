//
//  Card.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(Card*)card
{
    int score = 0;
    
    //For now, score is either 1 or 0 if contents are =
    if ([self.contents isEqualToString:card.contents])
    {
        score = 1;
    }
    return score;
}

@end
