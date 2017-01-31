//
//  TreeViewCell.h
//  TreeViewPrototype
//
//  Created by Varun Naharia on 26/08/15.
//

#import <Foundation/Foundation.h>
#import "UICheckButton.h"

@class TreeViewCell;

@protocol TreeViewCellDelegate <NSObject>
//@optional
- (BOOL) willCheckingInTreeViewCell:(TreeViewCell *)treeViewCell;
- (void) treeViewCell:(TreeViewCell *)treeViewCell checked:(BOOL)checked;
- (BOOL) willExpandingInTreeViewCell:(TreeViewCell *)treeViewCell;
- (void) treeViewCell:(TreeViewCell *)treeViewCell expanded:(BOOL)expanded;
@end

@interface TreeViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic) NSUInteger level;
@property(nonatomic) BOOL expanded;
@property(nonatomic) BOOL isFolder;
@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, assign) BOOL showCheckBox;
@property(nonatomic, assign) id <TreeViewCellDelegate> delegate;

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
                         level:(NSUInteger)level
                      expanded:(BOOL)expanded
                      isFolder:(BOOL)isFolder
                    isSelected:(BOOL)value;

@end
