//
//  ViewController.m
//  demo
//
//  Created by Ralph Shane on 24/01/2017.
//  Copyright © 2017 Ralph Shane. All rights reserved.
//

#import "ViewController.h"
#import "UITreeView.h"
#import "NodeData.h"

@interface ViewController () <UITreeViewDelegate>
@end

@implementation ViewController {
    UITreeView *_tree;
    TreeNode *_rootTreeNode;
}

#pragma mark UITreeViewDelegate
- (NSInteger) numberOfRowsInTreeView:(UITreeView *)treeView {
    return [_rootTreeNode visibleNodes].count;
}

- (TreeNode *) treeView:(UITreeView *)treeView treeNodeForRow:(NSInteger)row {
    return [[_rootTreeNode visibleNodes] objectAtIndex:row];
}

- (void) treeView:(UITreeView *)treeView didSelectForTreeNode:(TreeNode *)treeNode {
    NSLog(@"Node %@ selected", treeNode.title);
}

- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode checked:(BOOL)checked {
    NSLog(@"Node %@ checked = %d", treeNode.title, checked);
    treeNode.checked = checked;
    [_tree reloadData];
}

- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode expanded:(BOOL)expanded {
    NSLog(@"Node %@ expanded = %d", treeNode.title, expanded);
    treeNode.nodeState = expanded ? TreeNodeStateExpanded : TreeNodeStateCollapsed;
    if (treeNode.hasChildren) {
        [_tree reloadData];
    }
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

    _tree = [[UITreeView alloc] initWithFrame:CGRectMake(100, 60, 300, 300)];
    _tree.showCheckBox = YES;
    _tree.treeViewDelegate = self;
    _rootTreeNode = [NodeData createTree];

    [self.view addSubview:_tree];
    //UIFont *font =[UIFont fontWithName:@"Helvetica" size:10];
    //[_tree setFont:font];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    CGFloat left = 100;
    CGFloat top = 60;
    [super viewDidLayoutSubviews];
    CGSize size = self.view.frame.size;
    _tree.frame = CGRectMake(left, top, size.width-left*2, size.height-top*2);
}

@end
