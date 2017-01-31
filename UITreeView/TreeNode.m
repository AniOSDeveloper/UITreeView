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

- (void) addChild:(TreeNode *)newChild {
    newChild.parent = self;
    [_children addObject:newChild];
}

- (void) removeTreeNode:(TreeNode *)treeNode {
    [self _internalRemove:treeNode];
}

- (BOOL) _internalRemove:(TreeNode *)node {
    BOOL result = NO;
    for (TreeNode *child in _children) {
        if (node == child) {
            [_children removeObject:node];
            result = YES;
            break;
        }
        if (child.isFolder) {
            result = [child _internalRemove:node];
            if (result) {
                break;
            }
        }
    }
    return result;
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
