//
//  ViewController.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "ViewController.h"

#import "NetworkManager.h"
#import "RequestBlock.h"
#import "CategoryOperation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *simpleButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickButton:(id)sender {
    
    CategoryOperation *operation = [CategoryOperation new];
    RequestBlock *block = [RequestBlock initWithStartBlock:^{
        NSLog(@"start");
    } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
        NSLog(@"andSuccessBlock");
        NSLog(@"result: %@", result);
    } errorBlock:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
        NSLog(@"errorBlock");
        NSLog(@"eroor: %@", error);
    } networkErrorBlock:^{
        NSLog(@"networkErrorBlock");
    } finishBlock:^{
        NSLog(@"finishBlock");
    }];
    
    [[NetworkManager sharedInstance] requestOperation:operation withBlock:block];
}

@end
