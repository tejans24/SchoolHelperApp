//
//  AboutViewController.m
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"About.jpg"]];
	
	//alerts
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"This is a cool app"];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Thanks for viewing"];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Goodbye!" image:[UIImage imageNamed:@"thumbsup"]];


}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
