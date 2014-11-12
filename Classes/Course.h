//
//  Course.h
//  tabProject
//
//  Created by chengjie yin on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;

@interface Course : NSObject <NSCoding> {

}

// string for course title
@property (nonatomic, retain)NSString *title;

// string for course description
@property (nonatomic, retain)NSString *description;

// mutable array for storing tasks of the course
@property (nonatomic, retain)NSMutableArray *tasks;

// string for course instructor
@property (nonatomic, retain)NSString *instructor;

// string for instructor email
@property (nonatomic, retain)NSString *insEmail;

// string for course semester
@property (nonatomic, retain)NSString *semester;

// double for course grade
@property (readwrite)double currentGrade;

/**
 init method for the class
 */
-(id)init;

/**
 courseWithTitle method return a course object containing desired input string data
 */
+(id)courseWithTitle:(NSString *)newTitle 
               descrip:(NSString *)description 
		   instructor:(NSString *) instructor 
				email: (NSString *)email;

@end
