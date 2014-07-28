//
//  MDSearchBoxView.m
//  SearchBox
//
//  Created by Inozemtsev Vladimir on 24/06/14.
//  Copyright (c) 2014 Inozemtsev Vladimir. All rights reserved.
//

#import "MDSearchBoxView.h"

#define TOPVIEW_BIGSIZE 180.0f
#define TOPVIEW_NORMALSIZE 62.0f
#define TOPVIEW_SMALLSIZE 34.0f
#define ZERO_VALUE 0.0f
#define ONE_VALUE 1.0f
@implementation MDSearchBoxView


@synthesize progress=_progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30.0f)];
    if (self) {

    [self initialization];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
     self=[super initWithCoder:aDecoder];
    [self initialization];
    return  self;
}

-(void)setProgress:(float)progress
{
    if (_progress!=progress) {
        _progress=progress;
        [self changeSizeFromDouble];
    }
    
}


-(void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText=placeholderText;
    self.textfield.placeholder=_placeholderText;
}

#pragma mark-isHTTPS setter
-(void)setIsHTTPS:(BOOL)isHTTPS
{
    if(_isHTTPS!=isHTTPS)
    
    {
        _isHTTPS=isHTTPS;

        [self CreateLock];
            }
}
-(void)CreateLock;
{
    if (_isHTTPS) {
        self.leftImage.layer.opacity=ZERO_VALUE;
        self.lockImage.layer.opacity=ONE_VALUE;
    }
    else self.lockImage.layer.opacity=ZERO_VALUE;

    CATransition *transition=[self generateAnimation];
    [self.leftImage.layer addAnimation:transition forKey:@"fadeAnimation"];
    [self.lockImage.layer addAnimation:transition forKey:@"fadeAnimation"];
}


#pragma mark- coerce Set mode
-(void)coerceSetMode:(UIMDSearchBoxViewMode)mode
{
    _mode=mode;
}

#pragma mark-setMode


-(void)setMode:(UIMDSearchBoxViewMode)mode
{
    
    if(!_isEditing)
    {
            _mode=mode;
           if (_mode==MDSearchBoxViewSearchMode)
                {
               self.rightImage.alpha=ZERO_VALUE;
                }
            else
            {
              [self updateBrowserMode];
                [self layoutSubviews];
            }
    }
    
}
-(void)updateBrowserMode
{
    if(_mode==MDSearchBoxViewBrowserIdleMode)
    {
        [self.rightImage setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    }
    else
    {
        [self.rightImage setImage:[UIImage imageNamed:@"unrefresh"] forState:UIControlStateNormal];
    }
   
    [self runScaleAnimationOnView:self.rightImage duration:1.0 rotations:1.0 repeat:0];

}
#pragma mark-initialization
-(void)initialization
{
    self.mode=MDSearchBoxViewSearchMode;
    self.isHTTPS=false;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
        //init lock image
    self.rightImage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100,100)];
    [self.rightImage setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self.rightImage addTarget:self action:@selector(onClickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.lockImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock"]];
  
    self.leftImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lupa"]];
    

    _isEditing=false;
    //init text Field
     self.textfield=[[UICustomTextField alloc] initWithFrame:self.frame];
     self.textLabel = [[UILabel alloc] initWithFrame:self.frame];
     self.textfield.placeholder=@"Веб-поиск или имя сайта";
    [self.textfield addTarget:self action:@selector(textFieldShouldBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.textfield addTarget:self action:@selector(textFieldShouldEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [self.textfield addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.rightImage setUserInteractionEnabled:YES];
    self.textLabel.alpha=ZERO_VALUE;
    self.rightImage.alpha=ZERO_VALUE;
    [self.textLabel setBackgroundColor:[UIColor clearColor]];
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    self.textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:self.textfield];
    [self addSubview:self.textLabel];
    [self addSubview:self.lockImage];
    [self addSubview:self.rightImage];
    // [self insertSubview:_rightImage aboveSubview:self.textfield];
}

#pragma mark- layout
-(void)layoutSubviews
{
       CGRect frameTextField = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.textLabel.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    //init left image
    self.leftImage.frame=CGRectMake(self.textfield.bounds.origin.x-self.leftImage.frame.size.width, self.leftImage.frame.origin.y, self.bounds.size.height, self.bounds.size.height);
    
    self.contentMode=UIViewContentModeScaleAspectFit;
    
    
    //frames offsets
    frameTextField.origin.x=10.0;
    
    
    //set rightImage
    //measure
   frameTextField.size.width=  self.frame.size.width-frameTextField.origin.x;
   
    //set
    self.textfield.frame=frameTextField;

    self.rightImage.frame=CGRectMake(self.frame.size.width-self.frame.size.height*1.5, self.frame.size.height/2-self.rightImage.frame.size.height/2,45, 30);
    NSLog(@"%@",NSStringFromCGRect(CGRectMake(self.frame.size.width-self.frame.size.height*1.5, self.frame.size.height/2-self.rightImage.frame.size.height/2,self.frame.size.height*1.5, self.frame.size.height)) );
   
    self.leftImage.frame =CGRectMake(frameTextField.origin.x-self.frame.size.height/2, self.frame.size.height/2,self.frame.size.height/2,self.frame.size.height/2);
    self.lockImage.frame=CGRectMake(self.textLabel.frame.origin.x-self.lockImage.center.x, self.textLabel.frame.origin.y,self.frame.size.height,self.frame.size.height);
    self.lockImage.alpha=ZERO_VALUE;
    self.lockImage.center=CGPointMake(10, self.textfield.frame.size.height/2);

    if (_mode!=MDSearchBoxViewSearchMode) {
        self.rightImage.alpha=ONE_VALUE;
    }
   
}

#pragma mark-tap right image
-(void) onClickRightButton
{
    if (self.mode==MDSearchBoxViewBrowserIdleMode) {
        self.mode=MDSearchBoxViewBrowserLoadingMode;
        [self.delegate startRefresh];
    }
    else
    {
        [self.delegate stopLoading];
     self.mode=MDSearchBoxViewBrowserIdleMode;
    }
}
#pragma mark-animation Editing
-(void)EditingAnimation
{
    [UIView animateWithDuration:0.35
                     animations:^{
                         CGRect r = [self.textLabel.text boundingRectWithSize:self.textLabel.frame.size
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName:[self.textLabel font]}
                                                                      context:nil];
                         self.textfield.alpha=ONE_VALUE;
                         self.textLabel.center=CGPointMake(r.size.width/2+10.0f,self.textfield.frame.size.height/2-ONE_VALUE);
                         self.rightImage.alpha=ZERO_VALUE;
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             self.textfield.textColor=[UIColor blackColor];
                             self.textLabel.alpha=ZERO_VALUE;
                             self.textLabel.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                         }
                         
                     }];

}
#pragma mark-animation LostFocus
-(void)LostFocusAnimation
{
    _isEditing=false;
    self.textLabel.text=self.textfield.text;

    self.textfield.userInteractionEnabled=TRUE;
    self.textfield.textColor=[UIColor clearColor];
    CGRect r = [self.textLabel.text boundingRectWithSize:self.textLabel.frame.size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[self.textLabel font]}
                                                 context:nil];
    self.textLabel.center=CGPointMake(r.size.width/2+10.0f,self.textfield.frame.size.height/2-1.0f);
    self.textLabel.alpha=ONE_VALUE;
    
    [UIView animateWithDuration:0.35 animations:
     ^{
          self.textLabel.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    completion:^(BOOL finished) {
        if (_mode!=MDSearchBoxViewSearchMode) {
            self.rightImage.alpha=ONE_VALUE;
        }
    }];
}

#pragma mark-states settings
-(void)browserStateEditing
{
    self.textfield.clearButtonMode= UITextFieldViewModeWhileEditing;
    [self EditingAnimation];
}

-(void)browserStateLostFocus
{
 //
    if(self.textfield.text.length>0)
    {
        [self LostFocusAnimation];
        
    }
    else
    {
        self.rightImage.alpha=ZERO_VALUE;
    }
}

-(void)searchStateLostFocus
{
    self.leftImage.alpha=ZERO_VALUE;
    if (self.textfield.text.length>0)
    {
        [self LostFocusAnimation];
    }
    else self.leftImage.layer.opacity=ONE_VALUE;
}

-(void)searchStateEditing
{
    
    [self EditingAnimation];
}
#pragma mark-rotate image in Button
- (void) runScaleAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    self.rightImage.alpha=1.0f;
    self.rightImage.layer.opacity=1.0f;
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    [animation setDuration:0.20f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];

    
    [view.layer addAnimation:animation forKey:@"rotationAnimation"];
}

#pragma mark-NSString textFromTExtField
-(void)textFieldEditingChanged:(UITextField *)textField
{
    //self.textForField=textField.text;
}

-(void)setTextForField:(NSString *)textFromField
            {
    if (![_textForField isEqualToString:textFromField]&&!_isEditing)
    {
        self.textfield.text=textFromField;
        self.textLabel.text=textFromField;
         self.textLabel.alpha=ONE_VALUE;
        
         self.textfield.textColor=[UIColor clearColor];
        if (_mode!=MDSearchBoxViewSearchMode)
            self.rightImage.alpha=ONE_VALUE;
        else self.rightImage.alpha=ZERO_VALUE;
    }
}

- (void)textFieldShouldBeginEditing:(UITextField *)textField
{
    _isEditing=TRUE;
    self.isHTTPS=false;
    
    if (self.mode==MDSearchBoxViewSearchMode) {
            self.textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self searchStateEditing];
    }
    else
        [self browserStateEditing];
 }

- (void)textFieldShouldEndEditing:(UITextField *)textField
{
    
    
    if (self.mode==MDSearchBoxViewSearchMode) {
            self.textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self searchStateLostFocus];
    }
    else
        [self browserStateLostFocus];

     
}




-(void)changeSizeFromDouble
{
    CGFloat deltaY = (TOPVIEW_NORMALSIZE - TOPVIEW_SMALLSIZE + 18.0f) * (1.0f -_progress) * 0.5;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, deltaY);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.7f + _progress * 0.3f, 0.7f + _progress * 0.3f);
    CGFloat alpha = (_progress - 0.6f) / 0.4f;
    CGFloat textColor = (ONE_VALUE - alpha);
    if(_mode!=MDSearchBoxViewSearchMode)
    {
        
    if (_progress >= ONE_VALUE)
    {
       self.rightImage.alpha=1.0f;
    }
    else  self.rightImage.alpha=alpha;
    }
        self.rightImage.userInteractionEnabled=_progress >= ONE_VALUE;
    self.userInteractionEnabled = _progress >= ONE_VALUE;
    self.textLabel.textColor = [UIColor colorWithRed:textColor green:textColor blue:textColor alpha:ONE_VALUE];
    self.backgroundColor=[UIColor colorWithWhite:1 alpha:alpha];
    self.layer.affineTransform = CGAffineTransformConcat(translation, scale);
    
}


#pragma mark-helper
-(CATransition*)generateAnimation
{
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType:kCATransitionFade];
    [transitionAnimation setDuration:0.3f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transitionAnimation setFillMode:kCAFillModeBoth];
    return transitionAnimation;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
