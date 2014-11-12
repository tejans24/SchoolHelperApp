//
//  AddCourseViewController.h
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;
@class PickDateViewController;

@interface AddCourseViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>{
}


// single course object used for storing course information
@property(nonatomic, retain) Course *course;
	
// UILabel for displaying course title
@property(nonatomic, retain) IBOutlet UITextField *courseTitle;
	
// UILable for displaying course instructor
@property(nonatomic, retain) IBOutlet UITextField *courseInstructor;

// UILable for displaying instructor email
@property(nonatomic, retain) IBOutlet UITextField *courseEmail;

// UILable for displaying course description
@property(nonatomic, retain) IBOutlet UITextView *courseDescription;

// nsstring used to store description content
@property(nonatomic, retain) NSString *Description;

//scrollview for the view controller
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;

// used for picking a date for the course
@property(nonatomic, retain) IBOutlet PickDateViewController *pickDateView;

// UIButton for semester year
@property(nonatomic, retain) IBOutlet UIButton *yearButton;

// UIButton to save all changes
@property(nonatomic, retain) IBOutlet UIButton *saveButton;

// UIAlert for popping error messages
@property (nonatomic, retain) IBOutlet UIAlertView *alert;

// BOOL for error reporting
@property (readwrite) BOOL emailError;

@property (readwrite) int counter;


/**
 method for adding a course
 */
-(IBAction)add;

/**
 method for adding a semester year for the course
 */
-(IBAction)pickCourseDate;


@end
