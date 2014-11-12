//
//  FinalProjectAppDelegate.h
//  FinalProject
//
//  Created by chengjie yin on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class courseNavController;
@class courseTableViewController;
@class Course;

@interface FinalProjectAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	IBOutlet UITabBarController *rootController;
	IBOutlet courseNavController *courseNavControllerView;
	IBOutlet courseTableViewController *courseTableView;

    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

// the tab bar for the application
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

// the navigation controller for the application
@property (nonatomic, retain) IBOutlet courseNavController *courseNavControllerView;

// courseTableViewController used for sharing among all view controllers of the application
@property (nonatomic, retain) IBOutlet courseTableViewController *courseTableView;

// course object for storing course data
@property (nonatomic, retain) Course *currentCourse;


@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, retain) LabelViewController *labelView;



- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end

