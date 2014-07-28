//
//  MDViewController.m
//  SearchBox
//
//  Created by Inozemtsev Vladimir on 24/06/14.
//  Copyright (c) 2014 Inozemtsev Vladimir. All rights reserved.
//

#import "MDViewController.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)changeSizeFromDouble
{
    NSLog(@"sadasd");
}

-(IBAction)sliderValueChanged:(id)sender

{
    UISlider *slider=sender;
    self.SearchBox.progress=slider.value;
    self.CustomView.placeholderText=[NSString stringWithFormat:@"%f", slider.value];
     self.CustomView.progress= slider.value;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    return  self;
}

-(IBAction)tap:(id)sender
{
    self.CustomView.isHTTPS=true;
}
-(IBAction)setSearchMode:(id)sender
{
    self.CustomView.mode=MDSearchBoxViewSearchMode;
}



-(IBAction)setBrowserState:(id)sender
{
    if (self.CustomView.mode==MDSearchBoxViewBrowserIdleMode||self.CustomView.mode==MDSearchBoxViewBrowserLoadingMode) {
        self.CustomView.mode=MDSearchBoxViewSearchMode;
    }
    else self.CustomView.mode=MDSearchBoxViewBrowserIdleMode;
}
-(IBAction)setIdleBrowserMode:(id)sender
{
    self.CustomView.mode=MDSearchBoxViewBrowserIdleMode;
}

-(IBAction)setLoadingBrowserMode:(id)sender
{
    self.CustomView.mode=MDSearchBoxViewBrowserLoadingMode;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 //Do any additional setup after loading the view.

    self.CustomView.delegate=self;
    self.SearchBox.progress=1.0f;
    self.CustomView.progress= 1.0f;
    self.view.backgroundColor=[UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
