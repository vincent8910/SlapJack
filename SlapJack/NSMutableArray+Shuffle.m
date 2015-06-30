//
//  NSMutableArray+Shuffle.m
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

-(void)shuffle
{
    NSUInteger count = [self count];
    NSMutableArray *dupeArr = [self mutableCopy];
    count = [dupeArr count];
    [self removeAllObjects];
    
    for(int i = 0; i < count ; ++i){
        int nElements = (int)count - i;
        int n = (arc4random() % nElements);
        [self addObject:dupeArr[n]];
        [dupeArr removeObjectAtIndex:n];
    }
}

@end
