//
//  SJGameModel.h
//  SlapJack
//
//  Created by VincentChen on 2015/6/20.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#define SJNotificationGameDidEnd @"SJNotificationGameDidEnd"
typedef enum:int{
    SJGameStageBingo1,
    SJGameStageBingo2,
    SJGameStageClick,
    SJGameStageContinue,
    SJGameStageOver
}SJGameStage;

@class SJCard;

@interface SJGameModel : NSObject

@property (nonatomic) SJGameStage gameStage;
@property (nonatomic) int maxCards;
@property (nonatomic) int clickP1;
@property (nonatomic) int clickP2;
@property (nonatomic) int clickP3;
@property (nonatomic) int clickP4;
@property (nonatomic) int scoreP1;
@property (nonatomic) int scoreP2;
@property (nonatomic) int scoreP3;
@property (nonatomic) int scoreP4;

-(void) resetGame;
-(void) updateGameStage;
-(void) updateClick:(int)which;
-(void) notifyGameDidEnd;
-(void) calculateBingoLoser;
-(void) calculateClickLoser;
-(int) isLastClick;
-(int) getScore:(int)which;

-(SJCard *) cardNow;
-(SJCard *) nextCard;

@end
