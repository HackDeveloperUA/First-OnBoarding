//
//  FirtstContentVC.m
//  First-OnBoarding
//
//  Created by Uber on 03/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "FirtstContentVC.h"

@interface FirtstContentVC ()

@end

@implementation FirtstContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.textForTextView;
    [self.imageView setImage:[UIImage imageNamed:self.imageFile]];
 
}




@end
