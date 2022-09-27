//
//  main.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCWindowController/TCWindowController.h"
#import "TCWindowController/TCView/TCThread/TCThread.h"

int main(int argc, const char * argv[]) {
#pragma mark - NSApplication
    
    NSApplication *app = [NSApplication sharedApplication];
    
#pragma mark - NSScreen
    
    NSSize winSize = NSMakeSize(700, 500);
    
    NSScreen *screen = [NSScreen mainScreen];
    NSDictionary *description = [screen deviceDescription];
    NSSize displayPixelSize = [[description objectForKey:NSDeviceSize] sizeValue];
    
    NSRect frame = NSMakeRect(displayPixelSize.width/2-winSize.width/2, displayPixelSize.height/2-winSize.height/2, winSize.width, winSize.height);
    
#pragma mark - TCWindowController
    
    TCWindowController *controller = [[TCWindowController alloc] init];

#pragma mark - TCWindow
    
    controller.window = [[TCWindow alloc] initWithFrame:frame];
    
    [controller.window setTitle:@"TCDownloadReturn"];
    [controller.window setMinSize:NSMakeSize(700, 530)];
    [controller.window setDelegate: controller];
    
    //NSMakeSize(window.frame.size.width, window.frame.size.height)
    [controller.window makeKeyAndOrderFront:NSApp];

#pragma mark - TCView
    
    controller.view = [[TCView alloc] init];
    [controller.view setFrameSize: NSMakeSize(controller.window.frame.size.width, controller.window.frame.size.height)];
    [controller.view setWantsLayer:YES];
    [controller.view setNeedsDisplay:YES];
    controller.view.layer.backgroundColor = [[NSColor yellowColor] CGColor];
    
    [controller.window.contentView addSubview: controller.view];

#pragma mark - TCTextView
    
    controller.textView = [[TCTextView alloc] initWithFrame:NSMakeRect(
             10,
             controller.window.frame.size.height-30-10-controller.window.frame.size.height/100*12,
             controller.window.frame.size.width/100*45,
             controller.window.frame.size.height/100*12
    )];
    [controller.textView setMaxSize:NSMakeSize(screen.frame.size.width, 200)];
    [controller.textView setString:@"Hi Mattia!"];
    
    [controller.view addSubview: controller.textView];
    
// ====================================================================================================================
    
    controller.textViewR = [[TCTextView alloc] initWithFrame:NSMakeRect(
             controller.window.frame.size.width-controller.window.frame.size.width/100*45-10,
             controller.window.frame.size.height-30-10-controller.window.frame.size.height/100*12,
             controller.window.frame.size.width/100*45,
             controller.window.frame.size.height/100*12
    )];
    [controller.textViewR setMaxSize:NSMakeSize(screen.frame.size.width, 200)];
    [controller.textViewR setString:@"Ciao Mattia!"];
    
    [controller.view addSubview: controller.textViewR];
    
#pragma mark - TCButton
    
    controller.cancel = [[TCButton alloc] initWithRect: NSMakeRect(10, 10, 90, 40)];
    controller.cancel.title = @"Cancel";
    
    [controller.view addSubview: controller.cancel];

// =====================================================================================================================
    
    controller.ok = [[TCButton alloc] initWithRect: NSMakeRect(controller.window.frame.size.width-90-10, 10, 90, 40)];
    controller.ok.title = @"Ok";
    
    [controller.view addSubview: controller.ok];
    
#pragma mark - TCThread
    
    TCThread *thread = [[TCThread alloc] init];
    thread.myId = 1;
    
    thread.controller = [[TCWindowController alloc] init];
    thread.controller = controller;
    
    [controller.ok setTarget: thread];
    [controller.ok setAction: @selector(okButton)];
    
    NSLog(@"1 - %f", controller.view.frame.size.width);
    
    NSLog(@"----------------");
    
    [app run];
    return 0;
}
