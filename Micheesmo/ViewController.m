//
//  ViewController.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
//Properties
@property (weak, nonatomic) IBOutlet UILabel* flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck* cardDeck;
@end

@implementation ViewController

- (Deck*) cardDeck
{
    if(!_cardDeck) _cardDeck = [[PlayingCardDeck alloc]init];
    return _cardDeck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    NSString* count = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.flipsLabel.text = count;
}

- (IBAction)touchCardButton:(UIButton*)sender
{
    UIImage* cardFront = [UIImage imageNamed:@"card front"];
    UIImage* cardBack = [UIImage imageNamed:@"card back"];
    
    //First check that we can flip
    if(![self.cardDeck size])
    {
        [self setCard:sender title:@"" bgImg:cardBack];
        sender.enabled = NO;
        return;
    }

    //Assign new image and card based on the current ones
    if([sender.currentTitle length])
    {
        [self setCard:sender title:@"" bgImg:cardBack];
    }
    else
    {
        //Select a random card and display rank&suit
        Card* card = [self.cardDeck drawRandomCard];
        [self setCard:sender title:card.contents bgImg:cardFront];
    }
    
    self.flipCount++;
}

/*!
 setCard
 @discussion a utility method for setting the card btn
 @return void - sets bg img and title on card btn
 */
- (void) setCard:(UIButton*)sender title:(NSString*)title bgImg:(UIImage*)img
{
    //Set the image and title
    [sender setBackgroundImage:img forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateNormal];
}

@end
