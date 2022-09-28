//
//  main.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCWindowController/TCWindowController.h"
#import "TCWindowController/TCView/TCThread/TCThread.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
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
         [controller.textViewR setEditable:YES];
         [controller.textViewR setSelectable:YES];
         
         [controller.view addSubview: controller.textViewR];
         
#pragma mark - TCButton
        
        controller.cancel = [[TCButton alloc] initWithRect: NSMakeRect(10, 10, 90, 40)];
        controller.cancel.title = @"Cancel";
        
        [controller.view addSubview: controller.cancel];
        
// =====================================================================================================================
        
        controller.ok = [[TCButton alloc] initWithRect: NSMakeRect(controller.window.frame.size.width-90-10, 10, 90, 40)];
        controller.ok.title = @"Ok";
        
#pragma mark - TCThread
        
        /*
        thread.myId = 1;
        
        //thread.controller = [[TCWindowController alloc] init];
        //thread.controller = controller;
        
        thread.controller.textViewR = [[TCTextView alloc] initWithFrame:NSMakeRect(
               controller.window.frame.size.width-controller.window.frame.size.width/100*45-10,
               controller.window.frame.size.height-30-10-controller.window.frame.size.height/100*12,
               controller.window.frame.size.width/100*45,
               controller.window.frame.size.height/100*12
        )];
        
        [thread.controller.textViewR setMaxSize:NSMakeSize(screen.frame.size.width, 200)];
        //[thread.controller.textViewR setEditable:NO];
        //[thread.controller.textViewR setSelectable:NO];
        
        [controller.view addSubview: thread.controller.textViewR];
        */
        
        dispatch_queue_t codaGlobaleF = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_semaphore_t semaforo = dispatch_semaphore_create(1);
        
        
        for (int i=0; i<100; i++)
        {
            dispatch_async (codaGlobaleF,
           ^{
              dispatch_semaphore_wait(semaforo, DISPATCH_TIME_FOREVER);
                TCThread *thread = [[TCThread alloc] initWithController:controller];
                thread.myId = 1;
                
                dispatch_async(dispatch_get_main_queue(),
                ^{
                    //thread.controller = controller;
                    [controller.ok setTarget: thread];
                    [controller.ok setAction: @selector(okButton)];
                    
                    [controller.view addSubview: controller.ok];
                });
              dispatch_semaphore_signal(semaforo);
           });
        }

        //[controller.ok setTarget: thread];
        //[controller.ok setAction: @selector(okButton)];
        
        NSLog(@"1 - %f", controller.view.frame.size.width);
        
        dispatch_queue_t miaDispatchQueueSeriale =
        dispatch_queue_create("com.example.MiaDispatchQueueSeriale", DISPATCH_QUEUE_SERIAL);
        
        NSLog(@"%@", miaDispatchQueueSeriale);
        
        //dispatch_queue_t miaDispatchQueueConcorrente =
        //dispatch_queue_create("com.example.MiaDispatchQueueSeriale", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(miaDispatchQueueSeriale, ^{
            NSLog(@"Hello dispatch_async");
        });
        
        dispatch_retain(miaDispatchQueueSeriale);
        
        // ritenzione, utilizzo e rilascio
        dispatch_release(miaDispatchQueueSeriale);
        
// TODO: GRUPPO DI TASK ESEGUITI COME PRIMA PRIORITA DOPO IL MAIN THREAD
        
        dispatch_queue_t codaGlobale = dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_group_t gruppoTask = dispatch_group_create();
        
        dispatch_group_async (gruppoTask, codaGlobale, ^{NSLog(@"Eseguito Blocco 0");});
        dispatch_group_async (gruppoTask, codaGlobale, ^{NSLog(@"Eseguito Blocco 1");});
        dispatch_group_async (gruppoTask, codaGlobale, ^{NSLog(@"Eseguito Blocco 2");});
        
        dispatch_group_notify (gruppoTask, dispatch_get_main_queue(), ^{NSLog(@"done");});
        
        dispatch_release (gruppoTask);
        
        dispatch_queue_t codaAccessoConcorrenteDataBase = dispatch_queue_create ("com.example.CodaAccessoConcorrenteDataBase", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(codaAccessoConcorrenteDataBase, ^{
            NSLog(@"Blocco 1");
        });
        
        dispatch_barrier_async(codaAccessoConcorrenteDataBase, ^{
            NSLog(@"Barriera");
        });
        
        dispatch_async(codaAccessoConcorrenteDataBase, ^{
            NSLog(@"Blocco 2");
        });
        
        dispatch_release (codaAccessoConcorrenteDataBase);
        
        NSLog(@"----------------");
        
        [app run];
    }
    return 0;
}
