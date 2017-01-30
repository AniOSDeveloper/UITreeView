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

    TreeNode *treeNode = nil;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNodeForRow:)]) {
        treeNode = [_treeViewDelegate treeView:self treeNodeForRow:indexPath.row];
    }
    NSAssert(treeNode, @"Can't get the Tree Node data");

    TreeViewCell *cell = [[TreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier
                                                       level:[treeNode levelDepth]
                                                    expanded:(treeNode.nodeState == TreeNodeStateExpanded)
                                                    isFolder:(treeNode.nodeType == TreeNodeTypeFolder)
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
    TreeNode *treeNode = nil;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNodeForRow:)]) {
        treeNode = [_treeViewDelegate treeView:self treeNodeForRow:indexPath.row];
    }
    NSAssert(treeNode, @"Can't get the Tree Node data");

    if ([_treeViewDelegate respondsToSelector:@selector(treeView:didSelectForTreeNode:)]) {
        [_treeViewDelegate treeView:self didSelectForTreeNode:treeNode];
    }
}

- (void) setFont:(UIFont *)font {
    _font = font;
    [self reloadData];
}

#pragma mark TreeViewCellDelegate

- (void) treeViewCell:(TreeViewCell *)treeViewCell checked:(BOOL)checked {
    NSIndexPath *indexPath = [self indexPathForCell:treeViewCell];

    TreeNode *treeNode = nil;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNodeForRow:)]) {
        treeNode = [_treeViewDelegate treeView:self treeNodeForRow:indexPath.row];
    }
    NSAssert(treeNode, @"Can't get the Tree Node data");

    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:checked:)]) {
        [_treeViewDelegate treeView:self treeNode:treeNode checked:checked];
    }
}

- (void) treeViewCell:(TreeViewCell *)treeViewCell expanded:(BOOL)expanded {
    NSIndexPath *indexPath = [self indexPathForCell:treeViewCell];

    TreeNode *treeNode = nil;
    if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNodeForRow:)]) {
        treeNode = [_treeViewDelegate treeView:self treeNodeForRow:indexPath.row];
    }
    NSAssert(treeNode, @"Can't get the Tree Node data");

    if (treeNode.nodeType == TreeNodeTypeFolder) {
        if ([_treeViewDelegate respondsToSelector:@selector(treeView:treeNode:expanded:)]) {
            [_treeViewDelegate treeView:self treeNode:treeNode expanded:expanded];
        }
    }
}

@end
