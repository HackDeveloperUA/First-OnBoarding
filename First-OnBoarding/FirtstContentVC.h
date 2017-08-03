//
//  FirtstContentVC.h
//  First-OnBoarding
//
//  Created by Uber on 03/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedOnBoardingVC.h"

@interface FirtstContentVC : BasedOnBoardingVC

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (nonatomic, strong) NSString* textForTextView;
@property (nonatomic, strong) NSString *imageFile;


@end
