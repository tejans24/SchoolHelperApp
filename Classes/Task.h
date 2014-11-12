//
//  Task.h
//  tabProject
//
//  Created by chengjie yin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
	Homework,
	Exam,
	Quiz,
	NA
} Type;

@interface Task : NSObject <NSCoding>{

}

// string for storing task title
@property (nonatomic,retain)NSString *name;

// enum type for task type
@property (nonatomic, retain)NSString *type;

// double for task grade
@property (readwrite)double grade;

// NSDate for task due date
@property (nonatomic,retain)NSDate *dueDate;

// double for task grade weight
@property (readwrite)double weight;

// BOOL for task completion status
@property BOOL completed;

// string for task description
@property (nonatomic, retain)NSString *description;

// double for task max possible points
@property (readwrite)double maxPoints;

// string for course title of the task
@property (nonatomic,retain)NSString *courseName;

/**
 init method for the task
 */
-(id)init;

/**
 formatDate method used to format the NSDate information and return well formatted string
 */
-(NSString *) formatDate;

/**
 calculateGrade method for calculating grade for the task
 */
-(double)calculateGrade;

@end
