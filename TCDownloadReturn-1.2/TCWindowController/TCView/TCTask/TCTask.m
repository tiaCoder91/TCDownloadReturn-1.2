//
//  TCTask.m
//  TCDownloadReturn-1.2
//
//  Created by Mattia Leggieri on 27/09/22.
//

#import "TCTask.h"

@implementation TCTask

- (NSString *)myThread:(NSThread *)thread script:(NSString *)my_script withTextView:(NSTextView *)textView {
    //NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *path = @"/tmp/data_script.sh";
    
    NSData *data_script = [my_script dataUsingEncoding:NSUTF8StringEncoding];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:@"/tmp/data_script.sh"]) {
        if ([manager removeItemAtPath:@"/tmp/data_script.sh" error:nil])
            NSLog(@"File rimosso!");
    }
    
    [manager createFileAtPath:[NSString stringWithFormat:@"/tmp/data_script.sh"] contents:data_script attributes:nil];
    
    NSTask *task = [[NSTask alloc] init];
    
    [task setLaunchPath: @"/bin/bash"];
    [task setArguments: [NSArray arrayWithObjects: [NSString stringWithFormat:@"%@", path], nil] ];

    NSLog(@"path: %@", path);

    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError: pipe];

    NSFileHandle *file = [pipe fileHandleForReading];

    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    
    NSString *output = [[NSString alloc]
              initWithData:data
              encoding:NSUTF8StringEncoding
    ];
    
    NSLog(@"output: %@", output);
    
    /*
    // QUESTA È UNA PAUSA DEL THREAD
    for (int i = 0; i<3; i++) {
        sleep(1);
        NSLog(@"second = %i : thread = %@", i, [thread name]);
    }
    */
    
    return output;
}


@end
