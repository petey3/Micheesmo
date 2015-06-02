//
//  ViewController.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
//Properties
@property (strong, nonatomic) CardMatchingGame* gameLogic;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray* cardButtons;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@end

@implementation ViewController

- (CardMatchingGame*) gameLogic
{
    if(!_gameLogic) _gameLogic = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _gameLogic;
}

//we use deck creation in our gameLogic init, so its a helper
- (Deck*) createDeck { return [[PlayingCardDeck alloc]init]; }

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

- (IBAction)touchCardButton:(UIButton*)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.gameLogic chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void) updateUI
{
    for(UIButton* button in self.cardButtons)
    {
        NSUInteger cardBtnIndex = [self.cardButtons indexOfObject:button];
        Card* card = [self.gameLogic getCardAtIndex:cardBtnIndex];
        //figure out what should be displayed on the card
        NSString* title = card.isChosen ? card.contents : @"";
        UIImage* img = [UIImage imageNamed:card.isChosen ? @"card front" : @"card back"];
        [self setCard:button title:title bgImg:img];
        
        //Update buttons based on their match state
        button.enabled = !card.isMatched;
        
        //Update text
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)self.gameLogic.score];
    }
}

@end
