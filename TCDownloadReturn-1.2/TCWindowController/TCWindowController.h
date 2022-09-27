//
//  TCWIndowController.h
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "TCWindow.h"

@interface TCWindowController : NSObject <NSWindowDelegate>
@property (nonatomic, strong) TCWindow *window;
@property (nonatomic, strong) TCView *view;
@property (nonatomic, strong) TCTextView *textView, *textViewR;
@property (nonatomic, strong) TCButton *ok, *cancel;
@property (nonatomic, strong) TCTask *task;
@end
