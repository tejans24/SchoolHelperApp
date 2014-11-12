//
//  CalendarViewController.h
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <TapkuLibrary/TapkuLibrary.h>
@class Task;
@class Course;

@interface LabelViewController : UITableViewController {
	NSMutableArray *cells;
}

//counts number of exams
-(int)countExam;

//count number of homeworks
-(int)countHomework;

//counts number of quizes
-(int)countQuiz;

//counts number of completed tasks
-(int)countCompleted;


//course
@property (nonatomic, retain) Course *course;



@end
