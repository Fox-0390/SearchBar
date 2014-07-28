//
//  UICustomTextField.m
//  SearchBox
//
//  Created by Inozemtsev Vladimir on 16/07/14.
//  Copyright (c) 2014 Inozemtsev Vladimir. All rights reserved.
//

#import "UICustomTextField.h"

@implementation UICustomTextField
{
    UIImageView *_scopeIconImageView;
    UILabel *_placeholderLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonInit];
}

- (void)commonInit
{
    _scopeIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lupa"]];
    CGRect r=CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height);
    _placeholderLabel=[[UILabel alloc] initWithFrame:r];
    _placeholderLabel.textColor=[UIColor grayColor];
    [self addSubview:_placeholderLabel];
    [self addSubview:_scopeIconImageView];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    _placeholderLabel.alpha=0.0f;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text=placeholder;
    CGRect recta = [placeholder boundingRectWithSize:self.bounds.size
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:self.font}
                                                        context:nil];
    

    _placeholderLabel.frame=recta;
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [super textRectForBounds:bounds];
   }


- (void)layoutSubviews
{
    
    [super layoutSubviews];

     if ([self isFirstResponder])
     {
         [UIView animateWithDuration:0.35
                          animations:^{
                              _scopeIconImageView.center=CGPointMake(self.frame.origin.x-_scopeIconImageView.frame.size.width*2, self.frame.size.height/2 );
                              _placeholderLabel.center=CGPointMake(self.frame.origin.x+_placeholderLabel.frame.size.width/2, self.frame.size.height/2);
                          }];
         
         if (self.text.length>0) {
             _placeholderLabel.alpha=0.0f;
         }
         else _placeholderLabel.alpha=1.0f;
     }
        else
        {
     
    _placeholderLabel.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat offsetBetweenIconAndText = 6.0f;
    CGFloat clearButtonSize = 12.0f;

    NSString *measureString = nil;

    if (self.text.length > 0)
    {
        measureString = self.text;
        
        if (!(self.clearButtonMode == UITextFieldViewModeAlways || self.clearButtonMode == UITextFieldViewModeWhileEditing))
        {
            clearButtonSize = 0.0f;
           
        }
        _scopeIconImageView.hidden = YES;
    }
    else {
        _placeholderLabel.alpha=1.0f;
        measureString = _placeholderLabel.text;
        if (!(self.clearButtonMode == UITextFieldViewModeUnlessEditing))
        {
            clearButtonSize = 0.0f;
        }
        CGRect rect = [measureString boundingRectWithSize:self.frame.size
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:self.font}
                                                  context:nil];
        CGFloat iconOriginX = (self.frame.size.width / 2) - _scopeIconImageView.frame.size.width - (rect.size.width / 2) - offsetBetweenIconAndText - clearButtonSize;
        CGFloat iconOriginY = (self.frame.size.height / 2) - (_scopeIconImageView.frame.size.height / 2);
        CGRect iconFrame = _scopeIconImageView.frame;
        iconFrame.origin.x = iconOriginX;
        iconFrame.origin.y = iconOriginY;
        _scopeIconImageView.frame = iconFrame;
        _scopeIconImageView.hidden = NO;
    }
        }
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
