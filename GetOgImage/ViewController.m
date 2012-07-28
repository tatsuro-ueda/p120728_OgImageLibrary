//
//  ViewController.m
//  GetOgImage
//
//  Created by 達郎 植田 on 12/07/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textField;
@synthesize imageView;
@synthesize message;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setImageView:nil];
    [self setMessage:nil];
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
    
    // Get the web page HTML
    NSString *string = 
    [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    // prepare regular expression to find text
    NSError *error   = nil;
    NSRegularExpression *regexp =
    [NSRegularExpression regularExpressionWithPattern:
     @"<meta property=\"og:image\" content=\".+\""
                                              options:0
                                                error:&error];

    @try {
        // find by regular expression
        NSTextCheckingResult *match =
        [regexp firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        
        // get the first result
        NSRange resultRange = [match rangeAtIndex:0];
        NSLog(@"match=%@", [string substringWithRange:resultRange]); 
        
        if (match) {
            
            // get the og:image URL from the find result
            NSRange urlRange = NSMakeRange(resultRange.location + 35, resultRange.length - 35 - 1);
            NSURL *urlOgImage = [NSURL URLWithString:[string substringWithRange:urlRange]];
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlOgImage]];
        }
    }
    @catch (NSException *exception) {
        message.text = @"Exception";
    }
    @finally {
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textFieldTmp
{
    [textFieldTmp resignFirstResponder];
    return YES;
}
@end
