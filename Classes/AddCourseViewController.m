//
//  AddCourseViewController.m
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "AddCourseViewController.h"
#import "Course.h"
#import "FinalProjectAppDelegate.h"
#import "PickDateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "courseTableViewController.h"

@implementation AddCourseViewController
@synthesize courseInstructor, courseEmail, courseTitle, courseDescription, Description, course, scrollView, pickDateView, yearButton;
@synthesize saveButton, alert,  emailError, counter;


-(IBAction)add{

	//making sure the emai is valid
	if (![self.courseEmail.text isEqual:@"NA"] ) {
		if ([self.courseEmail.text rangeOfString:@"@"].location == NSNotFound || [self.courseEmail.text rangeOfString:@"."].location == NSNotFound) {
			self.alert.message = @"Invalid email address";
			self.emailError = YES;
		}
	}
	
	//email error
	if (self.emailError == YES) {
		[self.alert show];
		self.emailError = NO;
	}else {
		FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
		[delegate.courseNavControllerView popViewControllerAnimated:YES];
	}
}


-(IBAction)pickCourseDate{
	self.pickDateView = [[PickDateViewController alloc]init];
	self.pickDateView.course = self.course;
	
	//[self presentModalViewController:self.pickDateView animated:YES];
	
	// use navigation controller inside the delegate to push the view
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	[delegate.courseNavControllerView pushViewController:self.pickDateView animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// set up the scroll view
    self.scrollView.frame = CGRectMake(0, 0, 320, 460);
    [self.scrollView setContentSize:CGSizeMake(320, 656)];
    self.scrollView.scrollEnabled = YES;
	

	self.courseDescription.textAlignment = NSTextAlignmentLeft;
	
	self.navigationItem.hidesBackButton = YES;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background3.jpg"]];

	// get 2 images used for customized buttons
	UIImage *yourBackgroundImage = [[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	UIImage *pressImage = [[UIImage imageNamed:@"buttonPressed.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];

	// set normal and highlight conditions button use different image
	[self.yearButton setBackgroundImage:yourBackgroundImage forState:UIControlStateNormal ];
	[self.yearButton setBackgroundImage:pressImage forState:UIControlStateHighlighted];
	
	// button will have rounded corner and border line
	[self.yearButton.layer setCornerRadius:10];
	[self.yearButton.layer setMasksToBounds:YES];
	[self.yearButton.layer setBorderWidth:2.0f];
	[self.yearButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
	
	// same thing apply to saveButton
	[self.saveButton setBackgroundImage:yourBackgroundImage forState:UIControlStateNormal ];
	[self.saveButton setBackgroundImage:pressImage forState:UIControlStateHighlighted];
	
	[self.saveButton.layer setCornerRadius:10];
	[self.saveButton.layer setMasksToBounds:YES];
	[self.saveButton.layer setBorderWidth:2.0f];
	[self.saveButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
	
	self.alert = [[UIAlertView alloc] initWithTitle:@"Error Detected" message:@"NA" delegate:nil
										   cancelButtonTitle:@"OK" otherButtonTitles:nil];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated]; 

	self.scrollView.scrollsToTop = YES;
	
	self.title = self.course.title;
	self.courseTitle.text = self.course.title; 
	self.courseInstructor.text = self.course.instructor;
	self.courseEmail.text = self.course.insEmail;
	self.courseDescription.text = self.course.description;
	
	if (self.course.semester != nil) {
		[self.yearButton setTitle:self.course.semester forState:UIControlStateNormal];
	}else {
		[self.yearButton setTitle:@"N/A" forState:UIControlStateNormal];
	}

	[self.scrollView setContentOffset:CGPointMake(0,0) animated:NO];
}

// textView delegate method
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {	
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
	}
	
    return YES;
}

// textView delegate method
-(void)textViewDidEndEditing:(UITextView *)textView{
	if (textView == self.courseDescription) {
		self.course.description = textView.text;
	}
}

// textField delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

// textField delegate method
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == self.courseTitle) {
		self.course.title = textField.text;
	} else if (textField == self.courseInstructor) {
		self.course.instructor = textField.text;
	} else if (textField == self.courseEmail) {
		self.course.insEmail= textField.text;
	}
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
	[self.course release];
	[self.courseTitle release];
	[self.courseEmail release];
	[self.courseDescription release];
	[self.Description release];
	[self.scrollView release];
	[self.pickDateView release];
	[self.yearButton release];
	[self.saveButton release];
	[self.alert release];
    [super dealloc];
}


@end
