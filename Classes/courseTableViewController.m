//
//  courseTableViewController.m
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "courseTableViewController.h"
#import "Course.h"
#import "AddCourseViewController.h"
#import "FinalProjectAppDelegate.h"
#import "HomeworkViewController.h"
#import "TaskViewController.h"
#import "Task.h"
#import <TapkuLibrary/TKCalendarMonthView.h>
#import "LabelViewController.h"

@implementation courseTableViewController
@synthesize courseArray, courseTableView, course, addCourseView,homeworkTableView, addTaskView, task, index;
@synthesize courseDetailView;
@synthesize labelView;

-(NSString *)getFilePath{
	NSArray *segments = [NSArray arrayWithObjects:NSHomeDirectory(), @"Documents", @"course.plist", nil];
	return [NSString pathWithComponents:segments];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.labelView = [[[LabelViewController alloc] init] autorelease];

	self.courseTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
	self.title = @"Courses";
	self.courseTableView.separatorColor = [UIColor grayColor];
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	delegate.courseTableView = self;
	
	
	///////////////
	NSMutableArray *courseList = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
	
	if (courseList) {
		self.courseArray = courseList;
	}else {
		self.courseArray = [[NSMutableArray alloc] init];
	}

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

	
}


-(IBAction)addCourse{
	// initialize 
	if (self.addCourseView == nil) {
		self.addCourseView = [[AddCourseViewController alloc]initWithNibName:@"AddCourseViewController" bundle:nil];
	}
		
	Course *newCourse = [[Course alloc] init];
	self.course = newCourse;
	self.addCourseView.course = newCourse;

	self.addCourseView.title = @"Add Course";
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];

	[delegate.courseNavControllerView pushViewController:self.addCourseView animated:YES];
	
	[self.courseArray addObject: newCourse];
	
	// update the courseTableView inside the delegate which will be shared among all other view controller
	delegate.courseTableView = self;
	
	[newCourse release];
}

// action sheet methods
- (IBAction)buttonPress{
	UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"Course Option"
														delegate:self 
											   cancelButtonTitle:@"Cancel" 
										  destructiveButtonTitle:nil 
											   otherButtonTitles: @"Add Task", @"Task List View", @"Edit this Course" , nil] autorelease];

	[sheet showInView:self.view];

	
}

// action sheet methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// add task selection
	if (buttonIndex == 0) {
			
		Task *newTask = [[[Task alloc] init]autorelease];

		self.task = newTask;
		self.addTaskView.task = newTask;
		newTask.courseName = [[self.courseArray objectAtIndex:self.index.row]title];
		
		FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
		[delegate.courseNavControllerView pushViewController:self.addTaskView animated:YES];

		[[[self.courseArray objectAtIndex:self.index.row]tasks] addObject:newTask];
		
		delegate.courseTableView = self;
	}
	
	// display task list selection
	if (buttonIndex == 1) {

		self.course = [self.courseArray objectAtIndex:self.index.row];
		
		self.homeworkTableView.homeworkList = self.course.tasks;
		
		self.homeworkTableView.title = @"Task List";
		
		FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
		[delegate.courseNavControllerView pushViewController:self.homeworkTableView animated:YES];
	}
	
	// Edit course selection
	if (buttonIndex == 2){
		
		if (self.addCourseView == nil) {
			self.addCourseView = [[AddCourseViewController alloc]initWithNibName:@"AddCourseViewController" bundle:nil ];
		}
		self.course = [self.courseArray objectAtIndex:self.index.row];
		
		self.addCourseView.course = self.course;
		
		self.addCourseView.title = @"Edit Course";
		FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
		[delegate.courseNavControllerView pushViewController:self.addCourseView animated:YES];
		
		delegate.courseTableView = self;
	}
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	if (self.course) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:					  
							 [self.courseArray indexOfObject:self.addCourseView] inSection:0];
		NSArray *paths = [NSArray arrayWithObject:path]; 
		[self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:NO]; 
		self.course = nil;
	}
	
	NSMutableArray *list = [[[NSMutableArray alloc]init]autorelease];
	list = self.courseArray;
	
	// save the current array content into the plist file
	BOOL save = [NSKeyedArchiver archiveRootObject:list toFile:[self getFilePath]];
	
	if (!save) {
		NSLog(@"error saving tasks");
	}
	
	
}


#pragma mark -
#pragma mark Table view data source

// tableView delegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

// tableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.courseArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		cell.userInteractionEnabled = YES;
	}

	Course *currentCourse = [self.courseArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.textColor = [UIColor purpleColor];
	
	
    // Configure the cell...
	cell.textLabel.text = currentCourse.title;
	NSLog(@"%@", currentCourse.instructor);
	if (![currentCourse.instructor isEqualToString:@"N/A"] && ![currentCourse.instructor isEqualToString:@""]) {

		cell.detailTextLabel.text = [currentCourse.semester stringByAppendingFormat:@"   By %@", currentCourse.instructor ];    
	}else {
		cell.detailTextLabel.text = currentCourse.semester;
	}
    
    return cell;
}

// delegate method invoke when the user click the accessory button
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	self.index = indexPath;
	[self buttonPress];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		
		[self.courseArray removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationFade];
	}      
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	self.labelView = [[[LabelViewController alloc] init] autorelease];
	
	self.labelView.course = [self.courseArray objectAtIndex:indexPath.row];

	

	[self.navigationController pushViewController:self.labelView animated:YES];
	
	//FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
//
//
//	
//	self.labelView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//
//	[delegate.courseNavControllerView presentModalViewController:self.labelView animated:YES];
	

	

}




#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[self.courseArray release];
    [super dealloc];
}


@end

