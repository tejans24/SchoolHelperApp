//
//  HomeworkViewController.m
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeworkViewController.h"
#import "FinalProjectAppDelegate.h"
#import "HomeworkViewController.h"
#import "Task.h"
#import "TaskViewController.h"
#import "Course.h"
#import "courseTableViewController.h"


@implementation HomeworkViewController
@synthesize homeworkList, task, taskViewController, currentCourse;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem.title = @"Edit";
	
	self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground2.jpg"]];
	self.tableView.separatorColor = [UIColor blackColor];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.tableView reloadData];
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
	
	NSMutableArray *list = [[[NSMutableArray alloc]init]autorelease];
	list = delegate.courseTableView.courseArray;
	
	// save the current array content into the plist file
	BOOL save = [NSKeyedArchiver archiveRootObject:list toFile:[self getFilePath]];
	
	if (!save) {
		NSLog(@"error saving tasks");
	}
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.homeworkList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	Task *tempTask = [self.homeworkList objectAtIndex:indexPath.row];
	
	cell.textLabel.text = tempTask.name;
	
	if( tempTask.dueDate != nil){
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Due %@",
									 [[self.homeworkList objectAtIndex:indexPath.row] formatDate]];
	}
	
	cell.textLabel.text = [[self.homeworkList objectAtIndex:indexPath.row] name];
	
	// cell text display different color depend on different situation
	if(tempTask.completed == YES){
		
		if(tempTask.dueDate == nil){
			cell.detailTextLabel.text = [NSString stringWithFormat:@"No Due Date"];
			
		}
		
		cell.textLabel.textColor = [UIColor grayColor];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		cell.detailTextLabel.textColor = [UIColor grayColor];
	}	
	else{
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		//if the date is not null
		if(tempTask.dueDate != nil){
			
			//if you are comparing duedates
			if([tempTask.dueDate compare:[NSDate date]] == NSOrderedAscending){
				NSLog(@"lakjsdf");
				cell.textLabel.textColor = [UIColor redColor];
				cell.detailTextLabel.textColor = [UIColor redColor];
			}else{
				NSLog(@"i dont know");
				cell.textLabel.textColor = [UIColor blueColor];
				cell.detailTextLabel.textColor = [UIColor blueColor];
			}
			
		}else{
			cell.detailTextLabel.text = [NSString stringWithFormat:@"No Due Date"];
			cell.textLabel.textColor = [UIColor brownColor];
			cell.detailTextLabel.textColor = [UIColor brownColor];
		}
	}
	
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		[self.homeworkList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
     
}





#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	if (self.taskViewController == nil) {
		self.taskViewController = [[[TaskViewController alloc] initWithNibName:
									@"TaskViewController" bundle:nil] autorelease];
	}
	
	self.taskViewController.title = [[self.homeworkList objectAtIndex:indexPath.row] name];
	self.taskViewController.task = [self.homeworkList objectAtIndex:indexPath.row];
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	[delegate.courseNavControllerView pushViewController:self.taskViewController animated:YES];
}

	
-(NSString *)getFilePath{
	NSArray *segments = [NSArray arrayWithObjects:NSHomeDirectory(), @"Documents", @"course.plist", nil];
	return [NSString pathWithComponents:segments];
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
	[self.homeworkList release];
	[self.task release];
	[self.taskViewController release];
	[self.currentCourse release];

    [super dealloc];
}


@end

