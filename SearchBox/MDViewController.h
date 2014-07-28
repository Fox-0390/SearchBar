//
//  MDViewController.h
//  SearchBox
//
//  Created by Inozemtsev Vladimir on 24/06/14.
//  Copyright (c) 2014 Inozemtsev Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarTextField.h"
#import "MDSearchBoxView.h"
@interface MDViewController : UIViewController<MDSearchBoxViewDelegate>
@property (weak, nonatomic) IBOutlet SearchBarTextField *SearchBox;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet MDSearchBoxView *CustomView;
- (IBAction)tap:(id)sender;
- (IBAction)setBrowserState:(id)sender;
-(IBAction)setIdleBrowserMode:(id)sender;
-(IBAction)setSearchMode:(id)sender;
-(IBAction)setLoadingBrowserMode:(id)sender;
@end
