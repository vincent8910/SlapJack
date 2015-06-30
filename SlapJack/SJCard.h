//
//  SJCard.h
//  SlapJack
//
//  Created by VincentChen on 2015/6/20.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ViewController.h"

typedef enum : int
{
    SJCardSuitClub = 0,
    SJCardSuitSpade,
    SJCardSuitDiamond,
    SJCardSuitHeart
}SJCardSuit;

@interface SJCard : NSObject
@property (nonatomic) SJCardSuit suit;
@property (nonatomic) int digit;
@property (nonatomic) BOOL isFaceUp;

-(UIImage *)getCardImage;
+(NSMutableArray *) generateAPackOfCards;

@end
