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

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

#pragma mark - UITreeViewDelegate
- (NSInteger) numberOfRowsInTreeView:(UITreeView *)treeView {
    return [_rootTreeNode visibleNodes].count;
}

- (TreeNode *) treeView:(UITreeView *)treeView treeNodeForRow:(NSInteger)row {
    return [[_rootTreeNode visibleNodes] objectAtIndex:row];
}

- (NSInteger) treeView:(UITreeView *)treeView rowForTreeNode:(TreeNode *)treeNode {
    return [[_rootTreeNode visibleNodes] indexOfObject:treeNode];
}

- (void) treeView:(UITreeView *)treeView removeTreeNode:(TreeNode *)treeNode {
    NSLog(@"TreeNode \"%@\" removeFromParent", treeNode.title);
}

- (void) treeView:(UITreeView *)treeView didSelectForTreeNode:(TreeNode *)treeNode {
    NSLog(@"Node %@ selected", treeNode.title);
}

- (BOOL) treeView:(UITreeView *)treeView queryCheckableInTreeNode:(TreeNode *)treeNode {
    return YES;
}

- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode checked:(BOOL)checked {
    NSLog(@"Node %@ checked = %d", treeNode.title, checked);
}

- (BOOL) treeView:(UITreeView *)treeView queryExpandableInTreeNode:(TreeNode *)treeNode {
    return YES;
}

- (void) treeView:(UITreeView *)treeView treeNode:(TreeNode *)treeNode expanded:(BOOL)expanded {
    NSLog(@"Node %@ expanded = %d", treeNode.title, expanded);
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

    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    UIBarButtonItem *addFolder = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addfolder"] style:UIBarButtonItemStylePlain target:self action:@selector(addFolder:)];
    UIBarButtonItem *addObject = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addobject"] style:UIBarButtonItemStylePlain target:self action:@selector(addObject:)];
    self.navigationItem.rightBarButtonItems = @[edit, addFolder, addObject];
}

- (void) edit:(UIBarButtonItem *)sender {
    _tree.editing = !_tree.editing;
}

- (void) addFolder:(UIBarButtonItem *)sender {
}

- (void) addObject:(UIBarButtonItem *)sender {
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
