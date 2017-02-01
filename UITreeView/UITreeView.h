//
//  UITreeView.h
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//
//

#import <UIKit/UIKit.h>

@class TreeNode;
@class UITreeView;

@protocol UITreeViewDelegate <NSObject>
@required
- (NSInteger) numberOfRowsInTreeView:(UITreeView *)treeView;
- (TreeNode *) treeView:(UITreeView *)treeView treeNodeForRow:(NSInteger)row;
- (NSInteger) treeView:(UITreeView *)treeView rowForTreeNode:(TreeNode *)treeNode;
- (void) treeView:(UITreeView *)treeView removeTreeNode:(TreeNode *)treeNode;
- (void) treeView:(UITreeView *)treeView moveTreeNode:(TreeNode *)treeNode to:(TreeNode *)to;
- (void) treeView:(UITreeView *)treeView addTreeNode:(TreeNode *)treeNode;

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
- (void) insertTreeNode:(TreeNode *)treeNode;
@end
