//
//  TreeNode.m
//  TreeNodePrototype
//
//  Created by Varun Naharia on 26/08/15.
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

- (BOOL) containTreeNode:(TreeNode *)treeNode {
    TreeNode *parent = treeNode.parent;
    if (parent == nil) {
        return NO;
    }
    if (self == parent) {
        return YES;
    } else {
        return [self containTreeNode:parent];
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
