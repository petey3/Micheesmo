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
@property (weak, nonatomic) IBOutlet UIButton* restartButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl* gameModeControl;
@property (weak, nonatomic) IBOutlet UILabel* matchMsgLabel;
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

//mark a card as chosen
- (IBAction)touchCardButton:(UIButton*)sender
{
    //If this is the first card touch, mark game as started
    if(!self.gameLogic.gameStarted)
    {
        self.gameLogic.gameStarted = YES;
        //force game mode selection?
        self.gameModeControl.enabled = NO;
    }
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.gameLogic chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

//restart the game (or redeal, as the hw states)
- (IBAction)touchRestartButton:(UIButton*)sender
{
    //the restart message handles repopulating deck and wiping score
    [self.gameLogic freshGame:[self.cardButtons count] usingDeck:[self createDeck]];
    self.gameModeControl.enabled = YES; //allow people to pick the mode
    [self updateUI];
}

//select the game mode (2 vs 3 card match)
- (IBAction)selectGameMode:(UISegmentedControl *)sender
{
    //We know we want 2 or 3, so simply add to the index
    NSInteger mode = [sender selectedSegmentIndex] + 2;
    [self.gameLogic setGameMode:mode];
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
        self.matchMsgLabel.text = [self updateMatchMsg];
    }
}

/*!
 @discussion figure out what the match message should say by looking at the cards the game logic is currently considering
 @return a formatted message concerning the cards and potentially points to set the label to
 */
- (NSString*) updateMatchMsg
{
    NSString* message;
    MatchBox* matchbox = [self.gameLogic getLatestMatchState];
    if(matchbox.isMatchFull)
    {
        //if the match is full, print out a message reflecting the results
        BOOL goodPlay = matchbox.matchPoints > 0;
        
        //Acknowledge success
        NSString* goodStart = @"Matched ";
        NSString* badStart = @"Tried matching ";
        
        //Loop through chosen cards and print them out
        NSMutableString* startMessage = [NSMutableString stringWithString:(goodPlay ? goodStart : badStart)];
        for(int index=0; index < matchbox.chosenCards.count; index++)
        {
            Card* card = matchbox.chosenCards[index];
            [startMessage appendString:card.contents];
            if(index < matchbox.chosenCards.count - 1)[startMessage appendString:@" + "];
        }
        //Acknowledge points!
        [startMessage appendFormat:@"for %li points", matchbox.matchPoints];
        
        //Acknowledge success
        NSString* goodEnd = @"! \n Nice job!";
        NSString* badEnd = @"\n ...welp. Nice try";
        NSString* endMessage = matchbox.matchPoints > 0 ? goodEnd : badEnd;
        [startMessage appendString:endMessage];
        
        message = [NSString stringWithString:startMessage];
    }
    //if not full yet, they are still "thinking"
    else
    {
        //Loop through chosen cards and print them out
        NSMutableString* startMessage = [NSMutableString stringWithString:@"Chose "];
        for(int index=0; index < matchbox.chosenCards.count; index++)
        {
            Card* card = matchbox.chosenCards[index];
            [startMessage appendString:card.contents];
            if(index < matchbox.chosenCards.count - 1)[startMessage appendString:@", "];
        }
        
        //Remind them how many they need
        NSInteger remainingCards = matchbox.targetCount - matchbox.chosenCards.count;
        NSString* endMessage = [NSString stringWithFormat:@" you need %li more.", remainingCards];
        [startMessage appendString:endMessage];
        
        message = [NSString stringWithString:startMessage];
    }
    
    return message;
}

@end
