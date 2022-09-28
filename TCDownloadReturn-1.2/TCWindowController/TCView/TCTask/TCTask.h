//
//  TCTask.h
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 27/09/22.
//

#import <Cocoa/Cocoa.h>

@interface TCTask : NSTask
- (NSString *)myThread:(NSThread *)thread script:(NSString *)my_script;
@end

