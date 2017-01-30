//
//  UICheckButton.m
//  MyTreeViewPrototype
//
//  Created by Varun Naharia on 26/08/15.
//

#import "UICheckButton.h"

@implementation UICheckableButton {
    UIImageView *_checkImg;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        [self addTarget:self action:@selector(clickme:) forControlEvents:UIControlEventTouchUpInside];

        _checkImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_checkImg];

        [self setChecked:NO];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    static CGFloat margin = 5;
    CGFloat width = self.frame.size.height - margin*2;
    _checkImg.frame = CGRectMake(margin, margin, width, width);
}

- (void) clickme:(UICheckableButton *)sender {
    NSAssert(sender == self, @"Something went wrong");
    BOOL checked = !self.checked;
    [self setChecked:checked];
    if (_onCheckedChanged) {
        _onCheckedChanged(checked);
    }
}

- (void) setCheckedImage:(UIImage *)checkedImage {
    _checkedImage = checkedImage;
    [self setChecked:_checked];
}

- (void) setUncheckedImage:(UIImage *)uncheckedImage {
    _uncheckedImage = uncheckedImage;
    [self setChecked:_checked];
}

- (void) setChecked:(BOOL)checked {
    _checked = checked;
    _checkImg.image = checked ? _checkedImage : _uncheckedImage;
    [self setNeedsLayout];
}

@end
