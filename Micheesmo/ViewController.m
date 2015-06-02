//
//  ViewController.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//Properties
@property (weak, nonatomic) IBOutlet UILabel* flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation ViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    NSString* count = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.flipsLabel.text = count;
}

- (IBAction)touchCardButton:(UIButton*)sender
{
    UIImage* cardImg;// = [UIImage imageNamed:@"card back"];
    NSString* title;
    //Assign new image and card based on the current ones
    if([sender.currentTitle length])
    {
        cardImg = [UIImage imageNamed:@"card back"];
        title = @"";
    }
    else
    {
        cardImg = [UIImage imageNamed:@"card front"];
        title = @"A♠️";
    }
    
    //Set the image and title
    [sender setBackgroundImage:cardImg forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateNormal];
    
    self.flipCount++;
}

@end
