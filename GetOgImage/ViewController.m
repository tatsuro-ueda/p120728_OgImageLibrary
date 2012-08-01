//
//  ViewController.m
//  GetOgImage
//
//  Created by 達郎 植田 on 12/07/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "NSURL+OgImage.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textField;
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    textField.text = @"http://mainichi.jp/select/news/20120801mog00m040006000c.html";
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)request:(id)sender {
    
    [textField resignFirstResponder];

    // Web page address
    NSURL *url = [NSURL URLWithString:textField.text];
    
    // get og:image
    NSData *d = [NSData dataWithContentsOfURL:[NSURL ogImageURLWithURL:url]];
    imageView.image = [UIImage imageWithData:d];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textFieldTmp
{
    [textFieldTmp resignFirstResponder];
    return YES;
}


@end
