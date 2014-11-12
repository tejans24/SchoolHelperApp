//
//  PickDateViewController.h
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Course;

@interface PickDateViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

}

// single course object storing course data
@property(nonatomic, retain) Course *course;

// UIPickView for course date selection
@property(nonatomic, retain) IBOutlet UIPickerView *courseDatePicker;

// mutable array for picker selection items
@property(nonatomic, retain) NSMutableArray *datePickerItems;

// arra for semester selection
@property(nonatomic, retain) NSArray *semester;

/**
 IBAction method invoke when user done selection in the picker view
 */
- (IBAction) done;

/**
 IBAction method cancel the selection
 */
-(IBAction)cancel;
@end
