//
//  PickDateViewController.m
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PickDateViewController.h"
#import "Course.h"
#import "FinalProjectAppDelegate.h"

@implementation PickDateViewController

@synthesize courseDatePicker, datePickerItems, course, semester;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// initialize the year for the picker view selection
	NSMutableArray *year = [[NSMutableArray alloc]init];
	
	[year addObject:@"2010"];
	[year addObject:@"2011"];
	[year addObject:@"2012"];
	[year addObject:@"2013"];
	[year addObject:@"2014"];
	[year addObject:@"2015"];
	[year addObject:@"2016"];
	[year addObject:@"2017"];
	[year addObject:@"2018"];
	[year addObject:@"2019"];
	[year addObject:@"2020"];
	[year addObject:@"2021"];
	datePickerItems = [[NSArray alloc] initWithArray:year ];
	[year release];
	
	// initialize semester selection
	NSMutableArray *period = [[NSMutableArray alloc]init];
	[period addObject:@"Fall"];
	[period addObject:@"Summer"];
	[period addObject:@"Spring"];
	[period addObject:@"Winter"];
	
	semester = [[NSArray alloc] initWithArray:period];
	
	[period release];
}

// pickerView delegate method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

// pickerView delegate method
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == 0) {
		return [datePickerItems count];	
	}else if (component == 1) {
		return [semester count];
	}else {
		return 0;
	}

}

// pickerView delegate method
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) {
		return [datePickerItems objectAtIndex:row];
	}else if (component == 1) {
		return [semester objectAtIndex:row];
	}else {
		return @"a";
	}

}

-(IBAction)cancel{
	self.course.semester = nil;
}

- (IBAction) done{
	NSString *time = [self.datePickerItems objectAtIndex:[self.courseDatePicker selectedRowInComponent:0]];
	NSString *space = @", ";
	NSString *time2 = [self.semester objectAtIndex:[self.courseDatePicker selectedRowInComponent:1]];
	time = [time stringByAppendingFormat:@"%@", space];
	time = [time stringByAppendingFormat:@"%@", time2];
		
	NSLog(@"%@", time);
	
	self.course.semester = time;
	
	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate ];
	
	[delegate.courseNavControllerView popViewControllerAnimated:YES];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[self.course release];
	[self.courseDatePicker release];
	[self.datePickerItems release];
	[self.semester release];
    [super dealloc];
}


@end
