//
//  Task.m
//  tabProject
//
//  Created by chengjie yin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Task.h"


@implementation Task
@synthesize name, type, grade, dueDate, weight, completed, description, maxPoints, courseName;

-(void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.name forKey:@"text"];
	[aCoder encodeObject:self.dueDate forKey:@"dueDate"];
	[aCoder encodeDouble:self.grade forKey:@"grade"];
	[aCoder encodeDouble:self.weight forKey:@"weight"];
	[aCoder encodeObject:self.type forKey:@"taskType"];
	[aCoder encodeDouble:self.maxPoints forKey:@"maxPoints"];
	[aCoder encodeObject:self.description forKey:@"description"];
	[aCoder encodeObject:self.courseName forKey:@"courseName"];
	[aCoder encodeBool: self.completed forKey:@"completed"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.name = [aDecoder decodeObjectForKey:@"text"];
		self.dueDate = [aDecoder decodeObjectForKey:@"dueDate"];
		self.type = [aDecoder decodeObjectForKey:@"taskType"];
		self.grade = [aDecoder decodeDoubleForKey:@"grade"];
		self.weight = [aDecoder decodeDoubleForKey:@"weight"];
		self.description = [aDecoder decodeObjectForKey:@"description"];
		self.maxPoints = [aDecoder decodeDoubleForKey:@"maxPoints"];
		self.courseName = [aDecoder decodeObjectForKey:@"courseName"];
		self.completed = [aDecoder decodeBoolForKey:@"completed"];
	}
	
	return self;
}


-(id)init{
	if(self = [super init]){
		
		self.name = @"Untitled";
		self.type = @"NA";
		self.weight = 0;
		self.description = @"";
		self.courseName = @"";
		self.dueDate = nil;
		self.completed = NO;
		self.grade = 0;
		self.maxPoints = 0;
	}
	
	return self;
}

-(double)calculateGrade{
	if (self.grade == 0 || self.maxPoints == 0) {
		return 0;
	}
	
	return (self.grade / self.maxPoints) * self.weight;
}

-(NSString *) formatDate{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	//[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm"];
	NSLog(@"%@", [dateFormatter stringFromDate:self.dueDate]);
	return [dateFormatter stringFromDate:self.dueDate];
	
}

- (void)dealloc {
	[name release];
	[dueDate release];
	[type release];
	[description release];
	[courseName release];
    [super dealloc];
}

@end
