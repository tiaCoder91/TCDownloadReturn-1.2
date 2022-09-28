//
//  TCThread.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCThread.h"

@interface TCThread ()
@property (nonatomic, strong) TCThread *thread;
@end

@implementation TCThread {
    int num;
}

- (instancetype)initWithController:(TCWindowController *)controller {
    if (self = [super init]) {
        _controller = controller;
    }
    return self;
}

// Manca da prendere la stringa della textView di sinistra
- (void)okButton {
    _thread = [[TCThread alloc] initWithTarget:self selector:@selector(callScript) object:nil];
    _thread.name = @"Script thread";
        
    [_thread start];
}

- (void)callScript {
    num++;
    _controller.task = [[TCTask alloc] init];
    
    NSLog(@"Thread myThread %@", _thread.name);
    
    NSString *ffmpeg = @"/usr/local/bin/yt-dlp -f m4a --add-metadata --embed-thumbnail --ffmpeg-location /usr/local/bin https://www.youtube.com/watch?v=7X9kpHB7Aow";

    // ERROR: Senza open app non puoi modificare il campo  ( errore in _controller.textViewR.textStorage )
    
    NSString *script = @"";
    script = [NSString stringWithFormat:@"#!/bin/bash\nchmod +x /tmp/data_script.sh\necho \"ok script da objective-c data.\"\ncd /tmp\nif [ -f *.m4a ] ; then\nmv *.m4a ~/Desktop/*.m4a\nfi\nif [ -f ~/Desktop/*.m4a ] ; then\nopen -a Music ~/Desktop/*.m4a\nfi\nexit 0"];

    //script = [NSString stringWithFormat:@"#!/bin/bash\nchmod +x /tmp/data_script.sh\necho \"ok script da objective-c data.\"\ncd /tmp\n%@\nif [[ -n *.m4a ]] ; then\nmv *.m4a ~/Desktop/*.m4a\nopen -a Music ~/Desktop/*.m4a\nelse\necho \"Nessun file m4a\"\nfi", ffmpeg];
    
    NSString *text = [_controller.task myThread:_thread script:script];  // QUI DENTRO C'È LA PAUSA DEL THREAD
    
    dispatch_queue_t codaGlobaleF = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaforo = dispatch_semaphore_create(1);
    
    //for (int i=0; i<100; i++)
    //{
        dispatch_async (codaGlobaleF,
       ^{
          dispatch_semaphore_wait(semaforo, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_main_queue(),
            ^{
                NSLog(@"%@", _controller.textViewR.textStorage);
              
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
                
                [_controller.textViewR.textStorage setAttributedString: attrStr];
                [_controller.textViewR setTextColor: [NSColor blackColor]];
                _controller.textViewR.font = [NSFont systemFontOfSize:12.0];

            // TODO: Il piu 1 gli serve per aggiornare il testo ;-)    ------------------------------------v
                [_controller.textViewR setFrameSize: NSMakeSize(_controller.window.frame.size.width/100*45+1, _controller.textViewR.frame.size.height)];
                [_controller.textViewR setFrameOrigin: NSMakePoint(_controller.window.frame.size.width-_controller.textViewR.frame.size.width-10, _controller.window.frame.size.height-30-10-_controller.textViewR.frame.size.height)];
                
            // TODO: Questo lo risetta alle misure iniziali
                [_controller.textViewR setFrameSize: NSMakeSize(_controller.window.frame.size.width/100*45, _controller.textViewR.frame.size.height)];
            });
          dispatch_semaphore_signal(semaforo);
       });
    //}
    
    [_thread stop];
    
    NSLog(@"Finish with thread num : %lu", [[_thread valueForKeyPath:@"private.seqNum"] integerValue]);
}

- (void)stop {
    if ([self isFinished])
    {
        NSLog(@"Thread Finished!");
    }
    else if ([self isCancelled])
    {
        NSLog(@"Thread Cancelled!");
    }
    else
    {
        NSLog(@"Thread Executing!");
        [self cancel];
    }
    
    NSLog(@"Thread = %@ : is executing = %@", self, [self isExecuting] ? @"YES" : @"NO");
    
    if ([self isFinished])
    {
        NSLog(@"Thread Finished!");
    }
    else if ([self isCancelled])
    {
        NSLog(@"Thread Cancelled!");
    }
    else
    {
        NSLog(@"Thread Executing!");
    }
}

- (void)runLoop:(TCView *)t_view {

    for (int i = 1; i<4; i++) {
        sleep(1);
        NSLog(@"secondi = %i", i);
        sleep(1);
        [_controller.textView setFrame: NSMakeRect(
            10,
            _controller.window.frame.size.height-30-10-_controller.window.frame.size.height/100*12,
            _controller.window.frame.size.width/100*45*i,
            _controller.window.frame.size.height/100*12
        )];
        NSLog(@"2 - %f", _controller.textView.frame.size.width);
    }

    NSLog(@"2 - %f", _controller.view.frame.size.width);
    NSLog(@"_controller.view = %@", _controller.view);
    NSLog(@"Thread finish %@! with id : %i", self, _myId);
}

@end
