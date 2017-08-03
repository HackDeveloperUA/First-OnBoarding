//
//  SecondContentVC.m
//  First-OnBoarding
//
//  Created by Uber on 03/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "SecondContentVC.h"

@interface SecondContentVC ()

@end

@implementation SecondContentVC

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.beginUseAppBtn.layer.masksToBounds = YES;
    self.beginUseAppBtn.layer.cornerRadius  = CGRectGetWidth(self.beginUseAppBtn.frame)/35;
}

#pragma mark - Action

- (IBAction)beginUseAppAction:(id)sender {

}

@end
