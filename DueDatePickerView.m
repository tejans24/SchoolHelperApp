//
//  DueDatePickerView.m
//  FinalProject
//
//  Created by chengjie yin on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DueDatePickerView.h"
#import "Task.h"

@implementation DueDatePickerView
@synthesize picker;
@synthesize currentDate;
@synthesize task;


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated]; 
	
	self.title = @"Due Date Picker";
	self.navigationItem.hidesBackButton = YES;


}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)done {
	
	self.currentDate = self.picker.date;
	
	self.task.dueDate = self.currentDate;

	[self.navigationController popViewControllerAnimated:YES];
}



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
	[picker release];
	[task release];
	[currentDate release];
    [super dealloc];
}


@end
