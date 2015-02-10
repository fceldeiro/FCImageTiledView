//
//  ViewController.m
//  FCImageTiledView
//
//  Created by Fabian Celdeiro on 2/5/15.
//  Copyright (c) 2015 Fabián Celdeiro. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MyCustomView * customView = (MyCustomView*)[self.view.subviews firstObject];
        
        
        
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSArray  *filenames = @[
                                [mainBundle pathForResource:@"icoTc_banelco" ofType:@"png"],
                                [mainBundle pathForResource:@"icoTc_amex" ofType:@"png"],
                                [mainBundle pathForResource:@"icoTc_melicard" ofType:@"png"],
                                [mainBundle pathForResource:@"icoTc_debmaster" ofType:@"png"],
                                [mainBundle pathForResource:@"icoTc_bank_transfer" ofType:@"png"]];
        
        
        NSMutableArray * images = [NSMutableArray arrayWithCapacity:120];
        
        for (int i = 0 ;i<125; i++){
            
            NSString* filenameToUse = nil;
            
            NSInteger filenumber = i%5;
            filenameToUse = filenames[filenumber];
            [images addObject:[UIImage imageWithContentsOfFile:filenameToUse]];
            
        }
        
        [customView setImages:images animated:YES];
    });
    
  

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
