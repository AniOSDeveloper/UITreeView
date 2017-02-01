//
//  TreeViewCell.h
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//

#import <Foundation/Foundation.h>
#import "UICheckButton.h"

@class TreeViewCell;

@protocol TreeViewCellDelegate <NSObject>
//@optional
- (BOOL) queryCheckableInTreeViewCell:(TreeViewCell *)treeViewCell;
- (void) treeViewCell:(TreeViewCell *)treeViewCell checked:(BOOL)checked;
- (BOOL) queryExpandableInTreeViewCell:(TreeViewCell *)treeViewCell;
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
