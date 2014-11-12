//
//  DueDatePickerView.h
//  FinalProject
//
//  Created by chengjie yin on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface DueDatePickerView : UIViewController {

}

//date pickre object that is wired
@property (nonatomic, retain) IBOutlet UIDatePicker *picker;

//the date used to store picker's date 
@property (nonatomic, retain) NSDate *currentDate;

//current task that is assigned
@property (nonatomic, retain) Task *task;

//if user clicks on done button, the date is assigned to the task
- (IBAction)done;



@end
