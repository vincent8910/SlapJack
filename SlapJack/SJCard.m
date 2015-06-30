//
//  SJCard.m
//  SlapJack
//
//  Created by VincentChen on 2015/6/20.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "SJCard.h"

@implementation SJCard

-(UIImage *)getCardImage
{
    NSString *suit;
    switch (self.suit){
        case SJCardSuitClub:
            suit = @"club";
            break;
        case SJCardSuitSpade:
            suit = @"spade";
            break;
        case SJCardSuitDiamond:
            suit = @"diamond";
            break;
        case SJCardSuitHeart:
            suit = @"heart";
            break;
    }
    NSString *filename = [NSString stringWithFormat:@"%@-%d.png",suit,self.digit];
    return [UIImage imageNamed:filename];
}

+(NSMutableArray *) generateAPackOfCards{
    NSMutableArray *arr = [NSMutableArray array];
    SJCard *card;
    int suit,digit;
    for (suit=0;suit<4;suit++){
        for(digit=1;digit<=13;digit++){
            card = [[SJCard alloc] init];
            card.suit=suit;
            card.digit=digit;
            [arr addObject:card];
        }
    }
    
    return arr;
}

@end
