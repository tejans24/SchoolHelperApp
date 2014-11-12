//
//  TaskViewController.m
//  FinalProject
//
//  Created by Teja on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TaskViewController.h"
#import "Task.h"
#import "DueDatePickerView.h"
#import "FinalProjectAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation TaskViewController
@synthesize task, taskTitle, dueDate, weight, description;
@synthesize scrollView, completeButton, typeButton, grade, dueDatePickerView, button;
@synthesize maxPoints, saveButton;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"taskBackground.jpg"]];
	self.scrollView.frame = CGRectMake(0, 0, 320, 460);
	
    [self.scrollView setContentSize:CGSizeMake(320, 931)];
    self.scrollView.scrollEnabled = YES;
	
	self.navigationItem.hidesBackButton = YES;
	
	self.description.text = self.task.description;
	
	// create 2 cutomized image buttons
	UIImage *yourBackgroundImage = [[UIImage imageNamed:@"button2.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	UIImage *buttonPress = [[UIImage imageNamed:@"buttonPress2.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
	[self.button setBackgroundImage:yourBackgroundImage forState:UIControlStateNormal ];
	[self.button setBackgroundImage:buttonPress forState:UIControlStateHighlighted];

	[self.button.layer setCornerRadius:10];
	[self.button.layer setMasksToBounds:YES];
	[self.button.layer setBorderWidth:2.0f];
	[self.button.layer setBorderColor:[[UIColor grayColor] CGColor]];
	
	[self.saveButton setBackgroundImage:yourBackgroundImage forState:UIControlStateNormal ];
	[self.saveButton setBackgroundImage:buttonPress forState:UIControlStateHighlighted];
	
	[self.saveButton.layer setCornerRadius:10];
	[self.saveButton.layer setMasksToBounds:YES];
	[self.saveButton.layer setBorderWidth:2.0f];
	[self.saveButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated]; 
	
	self.title = self.task.name;

	self.taskTitle.text = self.task.name;
	self.weight.text = [NSString stringWithFormat:@"%.lf", self.task.weight];
	
	//if no due date
	if(self.task.dueDate == nil){
		
		[self.dueDate setTitle: @"No Date Selected" forState: UIControlStateNormal];
		
	}else{
		NSString *printDate = [self.task formatDate];
		
		[self.dueDate setTitle: printDate forState:  UIControlStateNormal];
	}
	
	if (self.task.completed == YES) {
		[self.completeButton setSelectedSegmentIndex: 0 ];
	}else {
		[self.completeButton setSelectedSegmentIndex:1];
	}
	
	self.grade.text = [NSString stringWithFormat:@"%.lf", self.task.grade];

	self.maxPoints.text = [NSString stringWithFormat:@"%.lf", self.task.maxPoints];
	
	if ([self.task.type isEqualToString:@"Homework"] ) {
		[self.typeButton setSelectedSegmentIndex:0];
	}else if ([self.task.type isEqualToString:@"Quiz"]) {
		[self.typeButton setSelectedSegmentIndex:1];
	}else if ([self.task.type isEqualToString:@"Exam"]){
		[self.typeButton setSelectedSegmentIndex:2];
	}else {
		[self.typeButton setSelectedSegmentIndex:3];
	}

	self.description.text = self.task.description;
	
	// scroll back to top every time the view controller loads
	[self.scrollView setContentOffset:CGPointMake(0, 0) animated: NO];

}


-(IBAction)save{
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
	[delegate.courseNavControllerView popViewControllerAnimated:YES];
}

-(IBAction)pickDate{
	if (self.dueDatePickerView == nil) {
		self.dueDatePickerView = [[DueDatePickerView alloc]initWithNibName:@"DueDatePickerView" bundle:nil];
	}
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	[delegate.courseNavControllerView pushViewController:self.dueDatePickerView animated:YES];
	self.dueDatePickerView.task = self.task;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
	
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
	if (textView == self.description) {
		self.task.description = textView.text;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == self.taskTitle) {
		self.task.name = textField.text;
	}
	
	if (textField == self.weight) {
		self.task.weight = [textField.text doubleValue];
	}
	
	if (textField == self.grade) {
		self.task.grade = [textField.text doubleValue];
	}

	if (textField == self.maxPoints) {
		self.task.maxPoints = [textField.text doubleValue];
	}

}



// segmented control button method down below
-(IBAction)typeSelection:(id)sender{
	if([sender selectedSegmentIndex] ==	0){
		self.task.type = @"Homework";
	}else if([sender selectedSegmentIndex] == 1){
		self.task.type = @"Quiz";
	}else if ([sender selectedSegmentIndex] == 2) {
		self.task.type = @"Exam";
	}
}


-(IBAction)completeSelection:(id)sender{
	if ([sender selectedSegmentIndex] == 0) {
		self.task.completed = YES;
	}else if ([sender selectedSegmentIndex] == 1) {
		self.task.completed = NO;
	}
}


- (void)dealloc {
	[self.task release];
	[self.taskTitle release];
	[self.dueDate release];
	[self.weight release];
	[self.description release];
	[self.grade release];
	[self.scrollView release];
	[self.completeButton release];
	[self.typeButton release];
	[DueDatePickerView release];
	[self.button release];
	[self.maxPoints release];
	[self.saveButton release];
    [super dealloc];
}


@end
