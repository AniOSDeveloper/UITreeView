//
//  TreeNode.h
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//

#import <Foundation/Foundation.h>


@interface TreeNode : NSObject

@property(nonatomic, strong) id value;
@property(nonatomic, strong, readonly) NSString *title;
@property(nonatomic, weak) TreeNode *parent;
@property(nonatomic, retain, readonly) NSMutableArray<TreeNode *> *children;
@property(nonatomic, assign, readonly) NSUInteger levelDepth;
@property(nonatomic, assign, readonly) BOOL isRoot;
@property(nonatomic, assign, readonly) BOOL hasChildren;
@property(nonatomic, assign) BOOL expanded;
@property(nonatomic, assign) BOOL isFolder;
@property(nonatomic, assign) BOOL checked;

- (instancetype) initWithValue:(id)value;
- (void) insertTreeNode:(TreeNode *)treeNode;
- (void) appendChild:(TreeNode *)newChild;
- (void) removeFromParent;
- (void) moveToDestination:(TreeNode *)destination;
- (BOOL) containsTreeNode:(TreeNode *)treeNode;
- (NSArray<TreeNode *> *) visibleNodes;
@end
