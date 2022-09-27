//
//  TCWIndowController.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCWindowController.h"

@implementation TCWindowController

/*
- (TCView *)view {
    if (!_view) {
        _view = [[TCView alloc] init];
        NSLog(@"Initializing %@", _view.class);
    }
    return _view;
}
*/

#pragma mark - Metodo per le modifiche della vista

- (void)windowDidResize:(NSNotification *)notification {

    TCWindow *window = notification.object;
    
// TODO: Modifiche posizione e misure degli oggetti
    
    NSSize viewSize = NSMakeSize(window.frame.size.width+30, window.frame.size.height);
    [_view setFrameSize: viewSize];
    
    NSPoint buttonOrigin = NSMakePoint(window.frame.size.width-90-10, 10);
    [_ok setFrameOrigin: buttonOrigin];
    
    [_textView setFrameSize: NSMakeSize(window.frame.size.width/100*45, _textView.frame.size.height)];
    [_textView setFrameOrigin: NSMakePoint(10, window.frame.size.height-30-10-_textView.frame.size.height)];
    
    [_textViewR setFrameSize: NSMakeSize(window.frame.size.width/100*45, _textViewR.frame.size.height)];
    [_textViewR setFrameOrigin: NSMakePoint(window.frame.size.width-_textViewR.frame.size.width-10, window.frame.size.height-30-10-_textViewR.frame.size.height)];
    
}

- (void)windowWillClose:(NSNotification *)notification {
    NSLog(@"Application closed!");
    exit(0);
}

@end
