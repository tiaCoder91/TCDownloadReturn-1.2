//
//  TCWindow.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCWindow.h"

@implementation TCWindow

- (instancetype)initWithFrame:(NSRect)frame {
    if (self = [super init]) {
        self = [[TCWindow alloc]
                initWithContentRect:frame
                styleMask: NSWindowStyleMaskTitled | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable
                backing:NSBackingStoreBuffered
                defer:NO
        ];
    }
    return self;
}

@end
