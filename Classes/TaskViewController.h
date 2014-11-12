//
//  TaskViewController.h
//  FinalProject
//
//  Created by Teja on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;
@class DueDatePickerView;


@interface TaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {

}

// single task object to store task information
@property(nonatomic, retain) Task *task;

// UITextField display task title
@property(nonatomic, retain) IBOutlet UITextField *taskTitle;

// UITextField display weight of task weight
@property(nonatomic, retain) IBOutlet UITextField *weight;

// UIButton for task due date
@property(nonatomic, retain) IBOutlet UIButton *dueDate;

// UITextView for task description
@property(nonatomic, retain) IBOutlet UITextView *description;

// UITextField for task grade
@property(nonatomic, retain) IBOutlet UITextField *grade;

// UIScrollView for the view controller
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;

// UISegmentedControl button for task completion status
@property(nonatomic, retain) IBOutlet UISegmentedControl *completeButton;

// UISegmentedControl button for task type
@property(nonatomic, retain) IBOutlet UISegmentedControl *typeButton;

// DueDatePickerView for task due date picker view
@property(nonatomic, retain) IBOutlet DueDatePickerView *dueDatePickerView;

// UIButton for task date
@property(nonatomic, retain) IBOutlet UIButton *button;

// UITextField for task maximum possible points
@property(nonatomic, retain) IBOutlet UITextField *maxPoints;

// UIButton fo
@property(nonatomic, retain) IBOutlet UIButton *saveButton;

/**
 IBAction method invode when the button is pressed, which navigate to 
 DueDatePickerView 
 */
-(IBAction)pickDate;

/**
 IBAction for saving changes and navigate back to task list table
 */
-(IBAction)save;

/**
 IBAction method for updating task type
 */
-(IBAction)typeSelection:(id)sender;

/**
 IBAction method for updating task completion status
 */
-(IBAction)completeSelection:(id)sender;


@end
