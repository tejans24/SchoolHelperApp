//
//  CalendarViewController.m
//  FinalProject
//
//  Created by Teja on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalendarViewController.h"
#import "Task.h"
#import "Course.h"
#import "FinalProjectAppDelegate.h"
#import "courseTableViewController.h"
#import <TapkuLibrary/TKCalendarMonthView.h>




@implementation CalendarViewController

NSString *DATE_FORMAT = @"yyyy-MM-dd 00:00:00 000";

@synthesize dataArray, dataDictionary, courseArray, calView, startDate, endDate;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	//alert
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Calendar View"];
	[self.calView reloadCal];

}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];	
	
	[self getData: self.startDate endDate: self.endDate];
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{

	//setting startDate and endDate
	self.startDate = startDate;
	self.endDate = lastDate;
	
	[self getData:startDate endDate:lastDate];
	
	return dataArray;
}

- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)d{
	[self.tableView reloadData];
}
	
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d{
	//if month changed
	[super calendarMonthView:mv monthDidChange:d];
	
	[self.tableView reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //table view
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
	NSArray *ar = [dataDictionary objectForKey:[self.monthView dateSelected]];
	cell.textLabel.text = [ar objectAtIndex:indexPath.row];
	
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (void) getData:(NSDate*)start endDate:(NSDate*)end{
	
	//creates arrays
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	self.courseArray = [NSMutableArray array];
	NSLog(@"Delegate Range: %@ %@",start,end);

	FinalProjectAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
	courseTableViewController *table = delegate.courseTableView;
	
	self.courseArray = table.courseArray;
	
		
	NSArray *array;

	int index;	

	//go though the course array
	for(int i = 0; i < [self.courseArray count]; i++){

		//go though the task arrray
		for(int j = 0; j < [[[self.courseArray objectAtIndex:i] tasks] count]; j++){
			
			Task *task = [[[self.courseArray objectAtIndex:i] tasks] objectAtIndex: j];

			//only if the task is not completed
			if(![task completed]){
				NSDate *date = [task dueDate];
			
				if(date != nil){
                    
					//dateformatter
					NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
					dateFormatter.dateFormat = DATE_FORMAT;
					[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
					
					//making it string
					NSString *timeStamp = [dateFormatter stringFromDate: date];
			
					NSDate *newDate = [dateFormatter dateFromString:timeStamp];
						
					array = [self.dataDictionary allKeys];

					if([array containsObject: newDate]){

						index = [array indexOfObject: newDate];
						NSLog(@"%d", index);
						NSDate *date = [array objectAtIndex:index];
						

						//get the key
						NSArray *array3 = [self.dataDictionary objectForKey:date];
						NSMutableArray *array4 = [[[NSMutableArray alloc] init] autorelease];
                        
						[array4 addObjectsFromArray:array3];
						[array4 addObject:[task name]];
                        [self.dataDictionary setObject: array4 forKey:newDate];
				
					}else{
						//adding string to dictionary
						[self.dataDictionary setObject:[NSArray arrayWithObjects:[task name],nil] forKey:newDate];
				
					}
				}
			
			}
			
		}
	}
	

	
//	NSDate *d = start;
//
//	array = [self.dataDictionary allKeys];
//
//	NSRange range = NSMakeRange(5,2);
//
//	NSString *month = [[start description] substringWithRange:range];
//	int total = 0;
//	if([month isEqualToString:@"12"] || [month isEqualToString:@"07"] || [month isEqualToString:@"04"]){
//		total = 42;
//	}else{
//		total = 35;
//	}
//
//	for (int k = 0; k <= total; k++) {
//		
//		
//		if([array containsObject: d]){
//			[self.dataArray addObject:[NSNumber numberWithBool:YES]];
//		}else{
//			[self.dataArray addObject:[NSNumber numberWithBool:NO]];
//
//		}
//		
//		//NSString *nowDate = [[d description]substringToIndex: 10];
////		NSString *nowDate2 = [[end description]substringToIndex: 10];
////		l++;
////		
////		
////		NSLog(@"%@ comapring with %@", nowDate, nowDate2);
////		if([nowDate isEqualToString:nowDate2]){
////			NSLog(@"SHIT BREALING");
////			break;
////		}
////		
//		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//		info.day++;
//		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//
//		
//	}

	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
	
	[self.dataArray release];
	[self.dataDictionary release];
	[self.calView release];
	[self.startDate release];
	[self.endDate release];

}


@end
