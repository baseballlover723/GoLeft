//
//  Score.m
//  GoLeft
//
//  Created by Ashok Vardhan Raja on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

#import "Score.h"


@implementation Score

@dynamic score;
@dynamic userName;
//+ (void) saveHighScore:(NSNumber *)score withName:(NSString *)name {
//    NSManagedObject *scoreObject = [[NSManagedObject alloc] initWithClassName:@"HighScore"];
//    [scoreObject setObject:score forKey:@"score"];
//    [scoreObject setObject:name forKey:@"name"];
//    [scoreObject save];
//    [scoreObject release];
//}
//
//
//
//PFQuery *query = [[PFQuery alloc] initWithClassName:@"HighScore"];
//query.limit = [NSNumber numberWithUnsignedInt:numberOfScores];
//query.order = @"-score";
//
//NSArray *objects = [NSObject findObjects:query];
//
//
//
//
//NSMutableArray *highScoreObjects = [[NSMutableArray alloc] initWithCapacity:numberOfScores];
//
//NSUInteger i = 0;
//for(PFObject *object in objects) {
//    HighScore *highScore = [[HighScore alloc] initWithName:[object objectForKey:@"name"] andScore:[object objectForKey:@"score"]];
//    [highScoreObjects insertObject:highScore atIndex:i];
//    [highScore release];
//    i++;
//}
//
//[query release];
//[[highScoreObjects autorelease];
//
//return highScoreObjects;
//

@end
