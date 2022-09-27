//
//  TCThread.h
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "../../TCWindowController.h"

@interface TCThread : NSThread
@property (nonatomic, strong) TCWindowController *controller;
@property (nonatomic) int myId;
- (void)okButton;
- (void)runLoop:(TCView *)t_view;
@end
