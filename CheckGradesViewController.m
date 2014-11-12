//
//  CheckGradesViewController.m
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <TapkuLibrary/TapkuLibrary.h>
#import "CheckGradesViewController.h"
#import "FinalProjectAppDelegate.h"
#import "courseTableViewController.h"
#import "Course.h"
#import "Task.h"


@implementation CheckGradesViewController
@synthesize coursePicker, courseList, message, courseScore;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Grade Calculator"];

	if (self.courseList == nil) {
		self.courseList = [[NSMutableArray alloc]init];
	}
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	self.courseList = delegate.courseTableView.courseArray;
	self.message.text = @"Select any existing course";
	self.courseScore.hidden = YES;
	
}

-(void)viewWillAppear:(BOOL)animated{
	self.message.text = @"Select any existing course";
	self.courseScore.hidden = YES;
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	
	if (delegate.courseTableView.courseArray != self.courseList) {
		self.courseList = delegate.courseTableView.courseArray;
	}
	
	[self.coursePicker reloadComponent:0];
	
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.courseList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

	return [[self.courseList objectAtIndex:row] title];

}


-(IBAction)checkGrade{
	int index = [self.coursePicker selectedRowInComponent:0];
	
	if ([self.courseList count ] == 0) {
		self.message.text = @"No Course is in the system";
		self.courseScore.hidden = NO;

	}else {
		Course *tempCourse = [self.courseList objectAtIndex:index];
		
		double currentGrade = 0;
		
		if ([tempCourse.tasks count] == 0) {
			self.message.text = [NSString stringWithFormat:@"No Task for this Course yet"];
			self.courseScore.text = @"";
		}else {
			
			for (int i = 0; i < [tempCourse.tasks count]; i++) {
				currentGrade += [[tempCourse.tasks objectAtIndex:i]calculateGrade];
			}
			
			self.message.text = @"The Grade for This Course is";
			self.courseScore.hidden = NO;
			self.courseScore.text = [NSString stringWithFormat:@"%.2lf%%", currentGrade];
		}
		
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
	[self.coursePicker release];
	[self.courseList release];
	[self.message release];
	[self.courseScore release];
    [super dealloc];
}


@end
