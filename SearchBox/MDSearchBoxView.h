//
//  MDSearchBoxView.h
//  SearchBox
//
//  Created by Inozemtsev Vladimir on 24/06/14.
//  Copyright (c) 2014 Inozemtsev Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomTextField.h"
@class MDSearchBoxView;
@protocol MDSearchBoxViewDelegate <NSObject>
-(void)startRefresh;
-(void)stopLoading;
@end
@interface MDSearchBoxView : UIView<UIApplicationDelegate>
typedef enum {
    MDSearchBoxViewSearchMode,
    MDSearchBoxViewBrowserIdleMode,
    MDSearchBoxViewBrowserLoadingMode
    
} UIMDSearchBoxViewMode;

typedef enum {
    MDLockGreen,
    MDLockGray,
    MDLockRed,
    MDLockInvisible
    
} UIMDLockState;
@property(nonatomic,strong) UICustomTextField *textfield;
@property(nonatomic,strong) UIButton *rightImage;
@property(nonatomic,strong) UIButton *lockImage;
@property(nonatomic,strong) UILabel *textLabel;
@property(nonatomic,strong) NSString* placeholderText;
@property(nonatomic) UIMDSearchBoxViewMode mode;
@property(nonatomic) BOOL isHTTPS;
//@property BOOL isEditing;
@property (nonatomic) UIMDLockState lockState;
@property(nonatomic) float progress;
@property(nonatomic,strong)NSString *textForField;
@property(nonatomic,strong) id <MDSearchBoxViewDelegate> delegate;
-(void)coerceSetMode:(UIMDSearchBoxViewMode)mode;
@end
