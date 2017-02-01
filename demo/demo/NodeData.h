//
//  NodeData.h
//  demo
//
//  Created by OneSecure on 29/01/2017.
//  Copyright © 2017 OneSecure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface NodeData : NSObject

@property(nonatomic, strong) NSString *name;

+ (TreeNode *) createTree;

@end
