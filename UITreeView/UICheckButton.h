//
//  UICheckButton.h
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//

#import <UIKit/UIKit.h>

@interface UICheckableButton : UIButton
@property(nonatomic, assign) BOOL checked;
@property(nonatomic, strong) UIImage *checkedImage;
@property(nonatomic, strong) UIImage *uncheckedImage;
@property(nonatomic, strong) BOOL(^willCheckedBeginning)(void);
@property(nonatomic, strong) void(^didCheckedChanged)(BOOL checked);
- (instancetype) initWithFrame:(CGRect)frame;
@end
