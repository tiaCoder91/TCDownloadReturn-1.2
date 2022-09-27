//
//  TCButton.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCButton.h"

@implementation TCButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (instancetype)initWithRect:(NSRect)rect
{
    if (self = [super init]) {
        NSLog(@"class %@ in method %s", self.class, sel_getName(_cmd));
        [self setFrame: rect];
        self.bezelStyle = NSBezelStyleRounded;
    }
    return self;
}

@end
