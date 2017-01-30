//
//  TreeViewCell.m
//  TreeViewPrototype
//
//  Created by Varun Naharia on 26/08/15.
//

#import "TreeViewCell.h"

static CGFloat IMG_HEIGHT_WIDTH = 20;
static CGFloat CELL_HEIGHT = 44;
static CGFloat SCREEN_WIDTH = 320;
static CGFloat LEVEL_INDENT = 32;
static CGFloat YOFFSET = 12;
static CGFloat XOFFSET = 6;

@implementation TreeViewCell {
    UICheckableButton *_arrowImageButton;
    UICheckableButton *_checkBox;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              level:(NSUInteger)level
           expanded:(BOOL)expanded
           isFolder:(BOOL)isFolder
         isSelected:(BOOL)value {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        _level = level;
        _expanded = expanded;
        _isSelected = value;
        _showCheckBox = YES;

        UIView *content = self.contentView;

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [content addSubview:titleLabel];
        _titleLabel = titleLabel;

        UICheckableButton *checkBox = [[UICheckableButton alloc] initWithFrame:CGRectMake(0, 0, IMG_HEIGHT_WIDTH, IMG_HEIGHT_WIDTH)];
        checkBox.checkedImage = [UIImage imageNamed:@"check_box"];
        checkBox.uncheckedImage = [UIImage imageNamed:@"uncheck_box"];
        [content addSubview:checkBox];
        __weak typeof(self) weakSelf = self;
        [checkBox setOnCheckedChanged:^(BOOL checked) {
            _isSelected = checked;
            if ([weakSelf.delegate respondsToSelector:@selector(treeViewCell:checked:)]) {
                [weakSelf.delegate treeViewCell:weakSelf checked:checked];
            }
        }];
        [checkBox setChecked:_isSelected];
        _checkBox = checkBox;

        UICheckableButton *arrowImageButton = [[UICheckableButton alloc] initWithFrame:CGRectMake(0, 0, IMG_HEIGHT_WIDTH, IMG_HEIGHT_WIDTH)];
        if (isFolder) {
            arrowImageButton.checkedImage = [UIImage imageNamed:@"open"];
            arrowImageButton.uncheckedImage = [UIImage imageNamed:@"close"];
        } else {
            arrowImageButton.checkedImage = [UIImage imageNamed:@"object"];
            arrowImageButton.uncheckedImage = [UIImage imageNamed:@"object"];
        }
        [arrowImageButton setOnCheckedChanged:^(BOOL checked) {
            _expanded = checked;
            if ([weakSelf.delegate respondsToSelector:@selector(treeViewCell:expanded:)]) {
                [weakSelf.delegate treeViewCell:weakSelf expanded:checked];
            }
        }];
        arrowImageButton.checked = _expanded;
        [content addSubview:arrowImageButton];
        _arrowImageButton = arrowImageButton;
    }
    return self;
}

#pragma mark -
#pragma mark Other overrides

- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;

    // if (!self.editing)
    {
        CGFloat boundsX = contentRect.origin.x;
        CGRect titleFrame = CGRectMake((boundsX + _level + 2) * LEVEL_INDENT,
                                       0,
                                       SCREEN_WIDTH - (_level * LEVEL_INDENT),
                                       CELL_HEIGHT);
        if (_showCheckBox == NO) {
            titleFrame.origin.x -= (IMG_HEIGHT_WIDTH + 5 + XOFFSET);
        }
        _titleLabel.frame = titleFrame;

        CGFloat cx = ((boundsX + _level + 1.8) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET);
        _checkBox.frame = CGRectMake(cx, YOFFSET, IMG_HEIGHT_WIDTH+5, IMG_HEIGHT_WIDTH+5);
        _checkBox.hidden = !_showCheckBox;

        CGFloat ax = ((boundsX + _level + 1) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET);
        _arrowImageButton.frame = CGRectMake(ax, YOFFSET, IMG_HEIGHT_WIDTH+5, IMG_HEIGHT_WIDTH+5);
    }
}

@end
