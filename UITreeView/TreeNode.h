//
//  TreeNode.h
//  TreeNodePrototype
//
//  Created by Varun Naharia on 26/08/15.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TreeNodeState) {
    TreeNodeStateCollapsed,
    TreeNodeStateExpanded,
};

typedef NS_ENUM(NSInteger, TreeNodeType) {
    TreeNodeTypeObject,
    TreeNodeTypeFolder,
};


@interface TreeNode : NSObject

@property(nonatomic, strong) id value;
@property(nonatomic, strong, readonly) NSString *title;
@property(nonatomic, weak) TreeNode *parent;
@property(nonatomic, retain, readonly) NSMutableArray<TreeNode *> *children;
@property(nonatomic, assign, readonly) NSUInteger levelDepth;
@property(nonatomic, assign, readonly) BOOL isRoot;
@property(nonatomic, assign, readonly) BOOL hasChildren;
@property(nonatomic, assign) TreeNodeState nodeState;
@property(nonatomic, assign) TreeNodeType nodeType;
@property(nonatomic, assign) BOOL checked;

- (instancetype) initWithValue:(id)value;
- (void) addChild:(TreeNode *)newChild;
- (NSArray<TreeNode *> *) visibleNodes;
@end
