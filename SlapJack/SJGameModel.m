//
//  SJGameModel.m
//  SlapJack
//
//  Created by VincentChen on 2015/6/20.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "SJGameModel.h"
#import "SJCard.h"
#import "NSMutableArray+Shuffle.h"
#import "math.h"

@interface SJGameModel();
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,strong) NSMutableArray *clicks;
@property (nonatomic,strong) SJCard* cardnow;
@property (nonatomic) int numOfCard;
@property (readwrite) BOOL didAnyoneWin;
@end

@implementation SJGameModel

-(id)init{
    self = [super init];
    if (self) {
        self.maxCards = 52;
        [self resetGame];
    }
    return self;
}

//nobody click, score in here is only mean this round, need to plus or not.
-(void) resetGame{
    self.cards=[SJCard generateAPackOfCards];
    [self.cards shuffle];
    self.clickP1=0;
    self.clickP2=0;
    self.clickP3=0;
    self.clickP4=0;
    self.scoreP1=0;
    self.scoreP2=0;
    self.scoreP3=0;
    self.scoreP4=0;
    self.numOfCard=0;
    self.gameStage=SJGameStageContinue;
}

//update the situation.
-(void) updateGameStage{
    if(self.gameStage==SJGameStageClick){
        //already wait for a while, find loser, end this round.
        [self calculateClickLoser];
        self.gameStage = SJGameStageOver;
    }else if ([self isLastClick] != 0 && self.gameStage == SJGameStageContinue){
        //if anyone click button but not bingo sintuation, wait for a while.
        self.gameStage=SJGameStageClick;
    }else if(self.gameStage == SJGameStageBingo2){
        //aready wiat for a while, find loser, end this round.
        [self calculateBingoLoser];
        self.gameStage = SJGameStageOver;
    }else if(self.gameStage == SJGameStageBingo1){
        //if bingo, wait for a while again.
        self.gameStage = SJGameStageBingo2;
    }else if (self.cardNow.digit == (self.numOfCard % 13)){
        //if bingo, wait for a while.
        self.gameStage = SJGameStageBingo1;
    }
}


-(void) notifyGameDidEnd{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:SJNotificationGameDidEnd object:self];
}

-(void) updateClick : (int) which {
    switch (which){
        case 1:
            self.clickP1=1;
            break;
        case 2:
            self.clickP2=1;
            break;
        case 3:
            self.clickP3=1;
            break;
        case 4:
            self.clickP4=1;
            break;
    }
}

-(void) calculateBingoLoser{
    //when bingo, non-click player lose.
    if(self.clickP1==0)
        self.scoreP1=1;
    if(self.clickP2==0)
        self.scoreP2=1;
    if(self.clickP3==0)
        self.scoreP3=1;
    if(self.clickP4==0)
        self.scoreP4=1;
}

-(void) calculateClickLoser{
    //when non-bingo, click player lose.
    if(self.clickP1==1)
        self.scoreP1=1;
    if(self.clickP2==1)
        self.scoreP2=1;
    if(self.clickP3==1)
        self.scoreP3=1;
    if(self.clickP4==1)
        self.scoreP4=1;
}

-(int) isLastClick{
    //return how many player click.
    int total = self.clickP1+self.clickP2+self.clickP3+self.clickP4;
    return total;
}

-(int) getScore:(int)which{
    switch (which){
        case 1:
            return self.scoreP1;
        case 2:
            return self.scoreP2;
        case 3:
            return self.scoreP3;
        case 4:
            return self.scoreP4;
    }
    return 0;
}

-(SJCard *) cardNow{
    SJCard *card = self.cardnow;
    return card;
}

-(SJCard *) nextCard{
    SJCard *card = self.cards[0];
    self.numOfCard++;
    [self.cards removeObjectAtIndex:0];
    self.cardnow = card;
    return card;
}

@end
