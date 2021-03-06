//
//  Score.h
//  GoLeft
//
//  Created by Ashok Vardhan Raja on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Score : NSManagedObject

@property (nonatomic,retain) NSNumber * score;
@property (nonatomic,retain) NSString * userName;

- (id) initWithName:(NSString *)nameObj andScore:(NSNumber *)scoreObj;
+ (void) saveHighScore:(NSNumber *)score withName:(NSString *)score;
+ (NSArray *) getTopHighScores:(NSUInteger)numberOfScores;

@end
