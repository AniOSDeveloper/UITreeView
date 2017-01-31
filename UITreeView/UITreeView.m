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
    TreeNode *_selectedNode;
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

- (void) setFont:(UIFont *)font {
    _font = font;
    [self reloadData];
    [self resetSelection];
}

- (void) resetSelection {
    NSInteger row = NSNotFound;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:rowForTreeNode:)]) {
        row = [_treeViewDelegate treeView:self rowForTreeNode:_selectedNode];
    }
    if (row != NSNotFound) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - UITableViewDataSource

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

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *treeNode = [self treeNodeForIndexPath:indexPath];
    return (treeNode.isRoot == NO);
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *treeNode = [self treeNodeForIndexPath:indexPath];
    return (treeNode.isRoot == NO);
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *treeNode = [self treeNodeForIndexPath:indexPath];
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:didSelectForTreeNode:)]) {
        [_treeViewDelegate treeView:self didSelectForTreeNode:treeNode];
    }
    _selectedNode = treeNode;
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    return nil;
}

#pragma mark - TreeViewCellDelegate

- (BOOL) queryCheckableInTreeViewCell:(TreeViewCell *)treeViewCell {
    BOOL allow = YES;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:queryCheckableInTreeNode:)]) {
        TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
        allow = [_treeViewDelegate treeView:self queryCheckableInTreeNode:treeNode];
    }
    return allow;
}

- (void) treeViewCell:(TreeViewCell *)treeViewCell checked:(BOOL)checked {
    TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
    treeNode.checked = checked;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:checked:)]) {
        [_treeViewDelegate treeView:self treeNode:treeNode checked:checked];
    }
}

- (BOOL) queryExpandableInTreeViewCell:(TreeViewCell *)treeViewCell {
    BOOL allow = YES;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:queryExpandableInTreeNode:)]) {
        TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
        allow = [_treeViewDelegate treeView:self queryExpandableInTreeNode:treeNode];
    }
    return allow;
}

- (void) treeViewCell:(TreeViewCell *)treeViewCell expanded:(BOOL)expanded {
    TreeNode *treeNode = [self treeNodeForTreeViewCell:treeViewCell];
    if (treeNode.isFolder) {
        treeNode.expanded = expanded;
        if (treeNode.hasChildren) {
            [self reloadData];
            [self resetSelection];
        }
        if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:expanded:)]) {
            [_treeViewDelegate treeView:self treeNode:treeNode expanded:expanded];
        }
    }
}

#pragma mark - retrieve TreeNode object from special cell

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
