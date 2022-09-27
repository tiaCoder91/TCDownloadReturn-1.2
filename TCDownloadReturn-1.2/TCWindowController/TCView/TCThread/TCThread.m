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

@implementation TCThread

- (void)okButton {
    _thread = [[TCThread alloc] initWithTarget:self selector:@selector(callScript) object:nil];
    _thread.name = @"Script thread";
    
    [_thread start];
}

- (void)callScript {
    _controller.task = [[TCTask alloc] init];
    
    NSLog(@"Thread myThread %@", _thread.name);
    
    NSString *ffmpeg = @"/usr/local/bin/yt-dlp -f m4a --add-metadata --embed-thumbnail --ffmpeg-location /usr/local/bin https://www.youtube.com/watch?v=7X9kpHB7Aow";
    
    NSString *script = [NSString stringWithFormat:@"#!/bin/bash\necho \"ok script da objective-c data.\"\ncd tmp\n%@\nmv *.m4a ~/Desktop\nopen -a Music ~/Desktop/*.m4a", ffmpeg];
    
    NSString *text = [_controller.task myThread:_thread script:script withTextView:_controller.textViewR];  // QUI DENTRO C'È LA PAUSA DEL THREAD
    
    [_thread stop];
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    [_controller.textViewR.textStorage setAttributedString: attrStr];
    [_controller.textViewR setTextColor: [NSColor blackColor]];
    _controller.textViewR.font = [NSFont systemFontOfSize:12.0];
    
// TODO: Il piu 1 gli serve per aggiornare il testo ;-)    ------------------------------------v
    [_controller.textViewR setFrameSize: NSMakeSize(_controller.window.frame.size.width/100*45+1, _controller.textViewR.frame.size.height)];
    [_controller.textViewR setFrameOrigin: NSMakePoint(_controller.window.frame.size.width-_controller.textViewR.frame.size.width-10, _controller.window.frame.size.height-30-10-_controller.textViewR.frame.size.height)];
    
// TODO: Questo lo risetta alle misure iniziali
    [_controller.textViewR setFrameSize: NSMakeSize(_controller.window.frame.size.width/100*45, _controller.textViewR.frame.size.height)];
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
