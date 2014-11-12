//
//  HomeworkViewController.h
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;
@class TaskViewController;
@class Course;


@interface HomeworkViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource >{
	NSMutableArray *homeworkList;	
}
// single Course object used for storing course information
@property (nonatomic, retain) Course *currentCourse;

// NSMutableArray used for storing all tasks
@property (nonatomic, retain) NSMutableArray *homeworkList;

// single Task object used for storing task information
@property (nonatomic, retain) Task *task;

// TaskViewController used for displaying edit task GUI page
@property (nonatomic, retain) IBOutlet TaskViewController *taskViewController;

@end
