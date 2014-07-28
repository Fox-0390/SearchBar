//
//  SearchBarTextField.h
//  Sputnik
//
//  Created by Denis Zamataev on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "UICustomTextField.h"
@interface SearchBarTextField : UITextField 
@property (nonatomic, assign) float verticalPadding;
@property (nonatomic, assign) float horizontalPadding;
@property (nonatomic, retain) UIImageView *icon;
@property float deleteButtonOffset;
@property (nonatomic) float progress;
- (void)hideText;
- (void)showTextAnimation:(float)duration;
@end
