//
//  TreeNode.m
//  UITreeView
//
//  Created by OneSecure on 2017/2/1.
//

#import "TreeNode.h"

@implementation TreeNode {
    NSArray *_flattenedTreeCache;
}

- (void) dealloc {
    NSLog(@"TreeNode \"%@\" dealloc", self.title);
}

- (instancetype) initWithValue:(id)value {
    if (self = [super init]) {
        _value = value;
        _children = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (NSString *) title {
    if (_value) {
        return [_value description];
    }
    return self.description;
}

- (NSArray<TreeNode *> *) visibleNodes {
    NSMutableArray *allElements = [[NSMutableArray alloc] init];
    [allElements addObject:self];
    if (_isFolder) {
        if (_expanded) {
            for (TreeNode *child in _children) {
                [allElements addObjectsFromArray:[child visibleNodes]];
            }
        }
    }
    return allElements;
}

- (void) insertTreeNode:(TreeNode *)treeNode {
    TreeNode *parent = nil;
    NSUInteger index = NSNotFound;
    if (self.isFolder) {
        parent = self;
        index = 0;
    } else {
        parent = self.parent;
        index = [parent.children indexOfObject:self];
    }
    treeNode.parent = parent;
    [parent.children insertObject:treeNode atIndex:index];
}

- (void) appendChild:(TreeNode *)newChild {
    newChild.parent = self;
    [_children addObject:newChild];
}

- (void) removeFromParent {
    TreeNode *parent = self.parent;
    if (parent) {
        [parent.children removeObject:self];
        self.parent = nil;
    }
}

- (void) moveToDestination:(TreeNode *)destination {
    NSAssert([self containsTreeNode:destination]==NO, @"[self containsTreeNode:destination] something gent wrong!");
    if (self == destination || destination == nil) {
        return;
    }
    [self removeFromParent];

    [destination insertTreeNode:self];
}

- (BOOL) containsTreeNode:(TreeNode *)treeNode {
    TreeNode *parent = treeNode.parent;
    if (parent == nil) {
        return NO;
    }
    if (self == parent) {
        return YES;
    } else {
        return [self containsTreeNode:parent];
    }
}

- (NSUInteger) levelDepth {
    NSUInteger cnt = 0;
    if (_parent != nil) {
        cnt += 1;
        cnt += [_parent levelDepth];
    }
    return cnt;
}

- (BOOL) isRoot {
    return (!_parent);
}

- (BOOL) hasChildren {
    return (_children.count > 0);
}

@end
