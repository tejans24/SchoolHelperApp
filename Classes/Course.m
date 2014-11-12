//
//  Course.m
//  tabProject
//
//  Created by chengjie yin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Course.h"


@implementation Course
@synthesize title, description, tasks, instructor, insEmail, currentGrade, semester;

-(void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.title forKey:@"courseTitle"];
	[aCoder encodeObject:self.description forKey:@"courseDescription"];
	[aCoder encodeObject:self.instructor forKey:@"instructor"];
	[aCoder encodeObject:self.tasks forKey:@"taskList"];
	[aCoder encodeObject:self.insEmail forKey:@"insEmail"];
	[aCoder encodeObject:self.semester forKey:@"semester"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.title = [aDecoder decodeObjectForKey:@"courseTitle"];
		self.description = [aDecoder decodeObjectForKey:@"courseDescription"];
		self.instructor = [aDecoder decodeObjectForKey:@"instructor"];
		self.tasks = [aDecoder decodeObjectForKey:@"taskList"];
		self.insEmail = [aDecoder decodeObjectForKey:@"insEmail"];
		self.semester = [aDecoder decodeObjectForKey:@"semester"];
	}
	
	return self;
}

-(id)init{
	if(self = [super init]){
		self.title = @"Untitled";
		self.description = @"";
		self.tasks = [[NSMutableArray alloc] init];
		self.insEmail = @"N/A";
		self.instructor = @"N/A";
		self.currentGrade = 0;
		self.semester = @"N/A";
	}
	
	return self;
}

+ (id)courseWithTitle:(NSString *)newTitle 
			  descrip:(NSString *)description 
		   instructor:(NSString *) instructor 
				email: (NSString *)email{
	Course *course = [[[Course alloc] init] autorelease];
	course.title = newTitle;
	course.description = description;
	course.insEmail = email;
	course.tasks = [[NSMutableArray alloc] initWithObjects: nil];
	
	return course;
}

- (void)dealloc {
	[self.title release];
	[self.description release];
	[self.tasks release];
	[self.instructor release];
	[self.insEmail release];
	[self.semester release];
	[super dealloc];

}
@end
