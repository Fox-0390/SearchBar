//
//  SearchBarTextField.m
//  Sputnik
//
//  Created by Denis Zamataev on 9/27/12.
//
//

#import "SearchBarTextField.h"


#define TOPVIEW_BIGSIZE 180.0f
#define TOPVIEW_NORMALSIZE 62.0f
#define TOPVIEW_SMALLSIZE 34.0f
@implementation SearchBarTextField
@synthesize horizontalPadding, verticalPadding, progress = _progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
      UIImage *iconImage = [UIImage imageNamed:@"mainpage-search_icon"];
    self.icon = [[UIImageView alloc] initWithImage:iconImage];
        CGRect searchIconFrame = self.icon.frame;
        searchIconFrame.origin.x =  8;
        searchIconFrame.origin.y = 8;
        self.icon.frame = searchIconFrame;
        [self addSubview:self.icon];

        
        self.horizontalPadding =  25;
        self.deleteButtonOffset = self.deleteButtonOffset == 0 ? 24.0f : self.deleteButtonOffset;
    }
    return self;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return     CGRectMake(bounds.origin.x + horizontalPadding,
                          bounds.origin.y + verticalPadding,
                          bounds.size.width - horizontalPadding - self.deleteButtonOffset,
                          bounds.size.height - verticalPadding);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)layoutSubviews
{
//    [super layoutSubviews];
    CGFloat progress = _progress;
  if (!self.text.length) {
//        progress = 1.0f;
        NSString *measureString = nil;
        measureString = self.placeholder;
        CGRect rect = [measureString boundingRectWithSize:self.frame.size
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:@{NSFontAttributeName:self.font}
                                context:nil];
        CGFloat offsetBetweenIconAndText = 8.0f;
        CGFloat iconOriginX = (self.frame.size.width / 2) - self.icon.frame.size.width - (rect.size.width / 2) - offsetBetweenIconAndText;
        self.icon.hidden = NO;
        self.icon.frame = CGRectMake(iconOriginX, self.icon.frame.origin.y, self.icon.frame.size.width, self.icon.frame.size.height);
    } else {
        self.icon.hidden=YES;
    }

    CGFloat alpha = (progress - 0.6f) / 0.4f;
    CGFloat textColor = (1.0f - alpha);
    self.textColor = [UIColor colorWithRed:textColor green:textColor blue:textColor alpha:1.0f];
    self.userInteractionEnabled = progress >= 1.0f;
    UIView *view = [self.subviews objectAtIndex:0];
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    view.layer.opacity = alpha ;
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            v.layer.opacity = alpha;
        }
    }
   
    CGFloat deltaY = (TOPVIEW_NORMALSIZE - TOPVIEW_SMALLSIZE + 18.0f) * (1.0f -_progress) * 0.5;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, deltaY);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.7f + progress * 0.3f, 0.7f + progress * 0.3f);
    
    self.layer.affineTransform = CGAffineTransformConcat(translation, scale);

  [super layoutSubviews];
    
    
}

- (void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsLayout];
}

- (void)hideText {
    for (int i = 1; i < self.subviews.count; i++) {
        UIView *v = self.subviews[i];
        v.hidden = YES;
        v.alpha = 0.0f;
    }
}

- (void)showTextAnimation:(float)duration {
    for (int i = 1; i < self.subviews.count; i++) {
        UIView *v = self.subviews[i];
        v.alpha = 0.0f;
        v.hidden = NO;
    }
    self.icon.alpha = 0.0f;
    self.icon.hidden = NO;
    [UIView animateWithDuration:duration animations:^{
        for (int i = 1; i < self.subviews.count; i++) {
            UIView *v = self.subviews[i];
            v.alpha = 1.0f;
        }
        self.icon.alpha = 1.0f;
    }];
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
