//
//  TCThread.h
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 26/09/22.
//

#import "../../TCWindowController.h"

@interface TCThread : NSThread
@property (nonatomic, strong, nullable) TCWindowController *controller;
@property (nonatomic) int myId;
- (instancetype _Nullable)initWithController:(TCWindowController * _Nullable)controller;
- (void)okButton;
- (void)runLoop:(TCView * _Nullable)t_view;
@end
