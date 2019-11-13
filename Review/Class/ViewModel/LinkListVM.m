//
//  LinkListVM.m
//  Review
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "LinkListVM.h"

// 定义链表节点
struct Node {
    int data;
    struct Node *next;
};

// 定义别名
typedef struct Node Node;

// 方法一：循环处理
void printLinkList(Node *h) {
    Node *p = h;
    while (p != NULL) {
        printf("%d", p->data);
        if (p->next == NULL) {
            printf("\n");
        } else {
            printf(", ");
        }
        p = p->next;
    }
}
Node *reverseLinkList(Node *h) {
    Node *result = NULL;
    Node *node = h;
    Node *next = NULL;
    while (node != NULL) {
        next = node->next;
        node->next = result;
        result = node;
        node = next;
    }
    
    return result;
}

// 方法二：递归处理
void printLinkList2(Node *h) {
    if (h == NULL) {
        return;
    }
    printf("%d", h->data);
    if (h->next == NULL) {
        printf("\n");
    } else {
        printf(", ");
    }
    printLinkList2(h->next);
}
Node *reverseLinkList2(Node *h) {
    if (h == NULL || h->next == NULL) {
        return h;
    }
    Node *result = reverseLinkList2(h->next);
    h->next->next = h;
    h->next = NULL;
    return result;
}

#define kLinkListCount          10

@interface LinkListVM ()

@property (assign, nonatomic) Node *linklist;

@end

@implementation LinkListVM

- (Node *)linklist {
    if (_linklist == NULL) {
        Node *current = NULL;
        for (int i = 1; i <= kLinkListCount; i++) {
            Node *node = malloc(sizeof(Node));
            node->data = i;
            if (i == kLinkListCount) {
                node->next = NULL;
            }
            if (i == 1) {
                _linklist = node;
            } else {
                current->next = node;
            }
            current = node;
        }
    }
    
    return _linklist;
}

- (void)dealloc {
    Node *node = self.linklist;
    Node *next = NULL;
    while (node != NULL) {
        next = node->next;
        free(node);
        node = next;
    }
    NSLog(@"----%@销毁了----", NSStringFromClass(self.class));
}
- (instancetype)init {
    if (self = [super init]) {
        @weakify(self)
        _loopLogCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                printLinkList(self.linklist);
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        _recursiveLogCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                printLinkList2(self.linklist);
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        _loopReverseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                self.linklist = reverseLinkList(self.linklist);
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        _recursiveReverseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                self.linklist = reverseLinkList2(self.linklist);
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
    }
    
    return self;
}

@end
