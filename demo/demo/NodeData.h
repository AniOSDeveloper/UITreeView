//
//  NodeData.h
//  demo
//
//  Created by Ralph Shane on 29/01/2017.
//  Copyright © 2017 Ralph Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface NodeData : NSObject

@property(nonatomic, strong) NSString *name;

+ (TreeNode *) createTree;

@end
