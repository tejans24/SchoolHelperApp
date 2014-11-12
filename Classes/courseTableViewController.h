//
//  courseTableViewController.h
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;
@class AddCourseViewController;
@class HomeworkViewController;
@class TaskViewController;
@class Task;
@class CourseDetailViewController;
@class MoreCellsViewController;
@class LabelViewController;

@interface courseTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	IBOutlet UITableView *courseTableView;
	NSMutableArray *courseArray;
}

// single course used for storing course information
@property (nonatomic, retain) Course *course;

// UItableView used for displaying course list
@property (nonatomic, retain) IBOutlet UITableView *courseTableView;

// NSMutableArray used for storing list of course information
@property (nonatomic, retain) NSMutableArray *courseArray;

// AddCourseViewController for displaying add course GUI page
@property (nonatomic, retain) AddCourseViewController *addCourseView;

// HomeworkViewController used for displaying task list for a selected course
@property (nonatomic, retain) IBOutlet HomeworkViewController *homeworkTableView;

// TaskViewController used for displaying add Task GUI page
@property (nonatomic, retain) IBOutlet TaskViewController *addTaskView;

// single task object used for storing task information
@property (nonatomic, retain) Task *task;

// NSIndexPath used for storing user selection on table view 
@property (nonatomic, retain) NSIndexPath *index;

// CourseDetailViewController used for displaying course detail information GUI page
@property (nonatomic, retain) CourseDetailViewController *courseDetailView;

@property (nonatomic, retain) LabelViewController *labelView;


/**
 method used for adding course to the table view list 
 */
-(IBAction)addCourse;

-(NSString *)getFilePath;

@end
