//
//  CalendarViewController.h
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "LabelViewController.h"
#import "Task.h"
#import "Course.h"


@implementation LabelViewController

@synthesize course;


- (void)viewDidLoad {
    [super viewDidLoad];
	

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];	
	
	
	cells = [[NSMutableArray alloc] init];
	
	self.title = course.title;
	
	static NSString *CellIdentifier = @"Cell";
	
	//Call cells in the edit table view that shows calls details
	
	TKLabelFieldCell *cell1 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell1.label.text = @"Name";
	cell1.field.text = self.course.title;	
	[cells addObject:cell1];
	[cell1 release];
	
	TKLabelFieldCell *cell2 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell2.label.text = @"Instructor's Name";
	cell2.field.text = course.instructor;
	NSLog(@"DESCRIPTON: %@", course.description);
	[cells addObject:cell2];
	[cell2 release];
	
	TKLabelFieldCell *cell3 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell3.label.text = @"Email";
	cell3.field.text = self.course.insEmail;
	[cells addObject:cell3];
	[cell3 release];
	
	TKLabelFieldCell *cell11 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell11.label.text = @"Semester";
	cell11.field.text = self.course.semester;
	[cells addObject:cell11];
	[cell11 release];
	
	TKLabelFieldCell *cell4 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	//cell4.label.text = @"Total Tasks";
	cell4.field.text = @"Description";
	[cells addObject:cell4];
	[cell4 release];
	
	
	
	TKLabelFieldCell *cell5 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell5.label.text = @"Number of Exams";
	cell5.field.text = [NSString stringWithFormat:@"%d", [self countExam]];
	[cells addObject:cell5];
	[cell5 release];

	
	TKLabelFieldCell *cell6 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell6.label.text = @"Homeworks";
	cell6.field.text = [NSString stringWithFormat:@"%d", [self countHomework]];;
	[cells addObject:cell6];
	[cell6 release];
	
	TKLabelFieldCell *cell7 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell7.label.text = @"Quizes";
	cell7.field.text = [NSString stringWithFormat:@"%d", [self countQuiz]];
	[cells addObject:cell7];
	[cell7 release];
	
	int counter = [self countCompleted];
	
	TKLabelFieldCell *cell8 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell8.label.text = @"Completed Tasks";
	cell8.field.text = [NSString stringWithFormat:@"%d", counter];
	[cells addObject:cell8];
	[cell8 release];
	
	TKLabelFieldCell *cell9 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell9.label.text = @"Incomplete Tasks";
	cell9.field.text = [NSString stringWithFormat:@"%d", [self.course.tasks count] - counter];
	[cells addObject:cell9];
	[cell9 release];
	
	TKLabelFieldCell *cell10 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell10.label.text = @"Total Tasks";
	cell10.field.text = [NSString stringWithFormat:@"%d", [self.course.tasks count]];
	[cells addObject:cell10];
	[cell10 release];
	
	
}
	
/**
 method used for calculating exams in a course
 */
-(int)countExam{
	int examTotal = 0;
	
	for (int i = 0; i < [self.course.tasks count]; i++) {
		if ([[[self.course.tasks objectAtIndex:i]type] isEqualToString:@"Exam"] ) {
			examTotal++;
		}
	}
	
	return examTotal;
}

-(int)countHomework{
	int homeworkTotal = 0;
	
	// go through array to match homework type object and increament the counter
	for (int i = 0; i < [self.course.tasks count]; i++) {
		if ([[[self.course.tasks objectAtIndex:i]type ] isEqualToString: @"Homework"]) {
			homeworkTotal++;
		}
	}
	
	return homeworkTotal;
}

/**
 method used for calculating number of quiz for the course
 */
-(int)countQuiz{
	int quizTotal = 0;
	
	for (int i = 0; i < [self.course.tasks count]; i++) {
		if ([[[self.course.tasks objectAtIndex:i]type ] isEqualToString:@"Quiz"] ) {
			quizTotal++;
		}	
	}
	
	return quizTotal;
}

/**
 method used for calculating number of completed tasks for the course
 */
-(int)countCompleted{
	int completedTotal = 0;
	
	for (int i = 0; i < [self.course.tasks count]; i++) {
		if ([[self.course.tasks objectAtIndex:i]completed ] == YES ) {
			completedTotal++;
		}
	}
	
	return completedTotal;
}


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//table count
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return [cells objectAtIndex:indexPath.row];
}

//when description is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if(indexPath.row == 4){
		NSString *des = self.course.description;
		
		if(des == nil || [des isEqualToString:@"" ]){
			[[TKAlertCenter defaultCenter] postAlertWithMessage: @"No description given."];
		}else{
			[[TKAlertCenter defaultCenter] postAlertWithMessage: des];
		}
	}

}

//giving cell size
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

	return 40.0;
	
}

//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return YES;
//}

- (void)dealloc {
	[cells release];
    [super dealloc];
}


@end

