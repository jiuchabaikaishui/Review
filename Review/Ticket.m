//
//  Ticket.m
//  Review
//
//  Created by apple on 2018/10/16.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "Ticket.h"

static Ticket *sharedInstance;
@implementation Ticket

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    
    return sharedInstance;
}

+ (instancetype)sharedTicket {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
