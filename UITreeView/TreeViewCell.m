//
//  TreeViewCell.m
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//

#import "TreeViewCell.h"

CGRect CGRectInflate(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x-dx, rect.origin.y-dy, rect.size.width+2*dx, rect.size.height+2*dy);
}

static CGFloat IMG_HEIGHT_WIDTH = 20;
static CGFloat XOFFSET = 3;

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
        _showCheckBox = NO;

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
        [checkBox setWillCheckedBeginning:^BOOL{
            BOOL allow = YES;
            if ([_delegate respondsToSelector:@selector(queryCheckableInTreeViewCell:)]) {
                allow = [_delegate queryCheckableInTreeViewCell:self];
            }
            return allow;
        }];
        [checkBox setDidCheckedChanged:^(BOOL checked) {
            _isSelected = checked;
            if ([_delegate respondsToSelector:@selector(treeViewCell:checked:)]) {
                [_delegate treeViewCell:self checked:checked];
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
        [arrowImageButton setWillCheckedBeginning:^BOOL{
            BOOL allow = isFolder;
            if (allow) {
                if ([_delegate respondsToSelector:@selector(queryExpandableInTreeViewCell:)]) {
                    allow = [_delegate queryExpandableInTreeViewCell:self];
                }
            }
            return allow;
        }];
        [arrowImageButton setDidCheckedChanged:^(BOOL checked) {
            if (isFolder == NO) {
                return;
            }
            _expanded = checked;
            if ([_delegate respondsToSelector:@selector(treeViewCell:expanded:)]) {
                [_delegate treeViewCell:self expanded:checked];
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

    CGSize size = self.contentView.bounds.size;
    CGFloat stepSize = size.height;
    CGRect rc = CGRectMake(_level * stepSize, 0, stepSize, stepSize);
    _arrowImageButton.frame = CGRectInflate(rc, -XOFFSET, -XOFFSET);

    _checkBox.hidden = !_showCheckBox;

    if (_showCheckBox) {
        rc = CGRectMake((_level + 1) * stepSize, 0, stepSize, stepSize);
        _checkBox.frame = CGRectInflate(rc, -XOFFSET, -XOFFSET);
        _titleLabel.frame = CGRectMake((_level + 2) * stepSize, 0, size.width - (_level + 3) * stepSize, stepSize);
    } else {
        _titleLabel.frame = CGRectMake((_level + 1) * stepSize, 0, size.width - (_level + 2) * stepSize, stepSize);
    }
}

@end
