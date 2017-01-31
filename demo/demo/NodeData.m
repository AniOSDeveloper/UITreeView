//
//  NodeData.m
//  demo
//
//  Created by Ralph Shane on 29/01/2017.
//  Copyright © 2017 Ralph Shane. All rights reserved.
//

#import "NodeData.h"
#import "TreeNode.h"

@implementation NodeData

- (NSString *) description {
    return [_name isKindOfClass:[NSString class]] ? _name : [super description];
}

+ (TreeNode *) createTree {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"]];
    return [self _internalCreateTree:dict];
}

+ (TreeNode *) _internalCreateTree:(NSDictionary *)dict {
    NodeData *data = [[NodeData alloc] init];
    data.name = dict[@"name"];

    NSArray *subNodes = dict[@"categories"];
    if ([subNodes isKindOfClass:[NSArray class]] == NO) {
        subNodes = nil;
    }

    TreeNode *node = [[TreeNode alloc] initWithValue:data];
    node.isFolder = (subNodes != nil);

    node.expanded = node.isFolder ? YES : NO;

    for (NSDictionary *subDict in subNodes) {
        if ([subDict isKindOfClass:[NSDictionary class]]) {
            TreeNode *subNode = [self _internalCreateTree:subDict];
            [node addChild:subNode];
        }
    }

    return node;
}

@end
