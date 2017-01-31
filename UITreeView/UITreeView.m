//
//  UITreeView.m
//  UITreeView
//
//  Created by Varun Naharia on 26/08/15.
//
//

#import "UITreeView.h"
#import "NodeData.h"

@interface UITreeView () <UITableViewDataSource, UITableViewDelegate, TreeViewCellDelegate>
@end

@implementation UITreeView {
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate=self;
        self.dataSource=self;
        self.separatorStyle= UITableViewCellSeparatorStyleNone;
        _font = [UIFont systemFontOfSize:16];

        self.layer.cornerRadius = 7.;
        self.layer.borderWidth = .5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if ([_treeViewDelegate respondsToSelector:@selector(numberOfRowsInTreeView:)]) {
        count = [_treeViewDelegate numberOfRowsInTreeView:self];
    }
    return count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    TreeNode *treeNode = [self treeNodeForIndexPath:indexPath];
    TreeViewCell *cell = [[TreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier
                                                       level:[treeNode levelDepth]
                                                    expanded:treeNode.expanded
                                                    isFolder:treeNode.isFolder
                                                  isSelected:treeNode.checked];
    cell.titleLabel.text = treeNode.title;
    cell.titleLabel.font = _font;
    cell.showCheckBox = _showCheckBox;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:didSelectForTreeNode:)]) {
        TreeNode *treeNode = [self treeNodeForIndexPath:indexPath];
        [_treeViewDelegate treeView:self didSelectForTreeNode:treeNode];
    }
}

- (void) setFont:(UIFont *)font {
    _font = font;
    [self reloadData];
}

#pragma mark TreeViewCellDelegate

- (BOOL) willCheckingInTreeViewCell:(TreeViewCell *)treeViewCell {
    return YES;
}

- (void) treeViewCell:(TreeViewCell *)treeViewCell checked:(BOOL)checked {
    TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
    treeNode.checked = checked;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:checked:)]) {
        [_treeViewDelegate treeView:self treeNode:treeNode checked:checked];
    }
}

- (BOOL) willExpandingInTreeViewCell:(TreeViewCell *)treeViewCell {
    return YES;
}

- (void) treeViewCell:(TreeViewCell *)treeViewCell expanded:(BOOL)expanded {
    TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
    if (treeNode.isFolder) {
        treeNode.expanded = expanded;
        if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:expanded:)]) {
            [_treeViewDelegate treeView:self treeNode:treeNode expanded:expanded];
        }
    }
}

#pragma mark -

- (TreeNode *) treeNodeForTreeViewCell:(TreeViewCell *)treeViewCell {
    NSIndexPath *indexPath = [self indexPathForCell:treeViewCell];
    return [self treeNodeForIndexPath:indexPath];
}

- (TreeNode *) treeNodeForIndexPath:(NSIndexPath *)indexPath {
    TreeNode *treeNode = nil;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNodeForRow:)]) {
        treeNode = [_treeViewDelegate treeView:self treeNodeForRow:indexPath.row];
    }
    NSAssert(treeNode, @"Can't get the Tree Node data");
    return treeNode;
}

@end
