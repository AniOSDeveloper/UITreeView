//
//  UITreeView.h
//  UITreeView
//
//  Created by Varun Naharia on 26/08/15.
//
//

#import <UIKit/UIKit.h>
#import "TreeNode.h"
#import "TreeViewCell.h"

@class UITreeView;

@protocol UITreeViewDelegate <NSObject>
@required
- (NSInteger) numberOfRowsInTreeView:(UITreeView *)treeView;
- (TreeNode *) treeView:(UITreeView *)treeView treeNodeForRow:(NSInteger)row;

//@optional
- (void) treeView:(UITreeView *)treeView didSelectForTreeNode:(TreeNode *)treeNode;
- (BOOL) treeView:(UITreeView *)treeView queryCheckableInTreeNode:(TreeNode *)treeNode;
- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode checked:(BOOL)checked;
- (BOOL) treeView:(UITreeView *)treeView queryExpandableInTreeNode:(TreeNode *)treeNode;
- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode expanded:(BOOL)expanded;
@end


@interface UITreeView : UITableView

@property(nonatomic, strong) UIFont *font;
@property(nonatomic, assign) BOOL showCheckBox;
@property(nonatomic, strong) TreeNode *treeNode;
@property(nonatomic, weak) id<UITreeViewDelegate> treeViewDelegate;

- (instancetype) initWithFrame:(CGRect)frame;

@end
