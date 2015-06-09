//
//  ViewController.m
//  testGCD
//
//  Created by huixinming on 6/6/15.
//  Copyright (c) 2015 huixinming. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    NSThread *tmpThread;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"main thread:%p",[NSThread currentThread]);
    //[self testBarrierBlockWithGlobalQueue];
    [self testBarrierBlockWithCreateQueue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testBarrierBlockWithCreateQueue
{
    NSLog(@"current iOS Version:%.1f",[[[UIDevice currentDevice] systemVersion] floatValue]);
    dispatch_queue_t queue = dispatch_queue_create("com.testBarrierGCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Excute block 1:%p",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Excute block 2:%p",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"Excute block 3:%p",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:4];
    });
    dispatch_async(queue, ^{
        NSLog(@"Excute block 4:%p",[NSThread currentThread]);
    });
}

- (void)testBarrierBlockWithGlobalQueue
{
    NSLog(@"current iOS Version:%.1f",[[[UIDevice currentDevice] systemVersion] floatValue]);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Excute block 1:%p",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Excute block 2:%p",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"Excute block 3:%p",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:4];
    });
    dispatch_async(queue, ^{
        NSLog(@"Excute block 4:%p",[NSThread currentThread]);
    });
}

@end
