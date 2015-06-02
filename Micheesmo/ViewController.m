//
//  ViewController.m
//  Micheesmo
//
//  Created by Eric Peterson on 6/1/15.
//  Copyright (c) 2015 Eric Peterson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)touchCardButton:(UIButton *)sender
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
}

@end
