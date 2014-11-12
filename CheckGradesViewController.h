//
//  CheckGradesViewController.h
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TKCalendarMonthView.h>


@interface CheckGradesViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{

}

// UIPickerView for course selection
@property (nonatomic, retain) IBOutlet UIPickerView *coursePicker;

// mutable array storing course list data
@property (nonatomic, retain) NSMutableArray *courseList;

// UILabel for displaying a message
@property (nonatomic, retain) IBOutlet UILabel *message;

// UILable for displaying course score
@property (nonatomic, retain) IBOutlet UILabel *courseScore;

/**
 IBAction method for calculating grade for the course
 */
-(IBAction)checkGrade;
@end
