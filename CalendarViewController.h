//
//  CalendarViewController.h
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <TapkuLibrary/TapkuLibrary.h>
#import <UIKit/UIKit.h>

@class Task;
@class Course;
@class FinalProjectAppDelegate;

@interface CalendarViewController : TKCalendarMonthTableViewController {

	NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
	TKCalendarMonthView *calView;
}

- (void) getData:(NSDate*)start endDate:(NSDate*)end;

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (retain,nonatomic) NSMutableArray *courseArray;
@property (retain, nonatomic) TKCalendarMonthView *calView;
@property (retain, nonatomic) NSDate *startDate;
@property (retain, nonatomic) NSDate *endDate;


@end
