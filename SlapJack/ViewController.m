//
//  ViewController.m
//  Blackjacks
//
//  Created by ShihHong on 2015/4/20.
//  Copyright (c) 2015年 ShihHong. All rights reserved.
//

#import "ViewController.h"
#import "SJGameModel.h"
#import "SJCard.h"

@interface ViewController();
@property (nonatomic,strong) SJGameModel *gameModel;
@property (nonatomic) int numOfCard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filePath=[[NSBundle mainBundle] pathForResource:@"HB" ofType:@"mp3"];
    self.fileData=[NSData dataWithContentsOfFile:self.filePath];
    audioPlayer = [[AVAudioPlayer alloc] initWithData:self.fileData error:nil];
    audioPlayer.delegate=self;
    self.p1=0;
    self.p2=0;
    self.p3=0;
    self.p4=0;
    //reset player score, only reset when start the apllication
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self restartGame];
    //first time we run the game, start from here.
}

//alloc game model
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.gameModel = [[SJGameModel alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationGameDidEnd:) name:SJNotificationGameDidEnd object:self.gameModel];
    }
    return self;
}

//get next card and get card's image, play hearbeat sound
- (void) renderCards{
    SJCard *card = [self.gameModel cardNow];
    if(audioPlayer!=nil) {
        if([audioPlayer prepareToPlay])
            [audioPlayer play];
    }
    self.TableCard.image = [card getCardImage];
}

-(void) restartGame{
    [self.gameModel resetGame];
    self.TableCard.image = [UIImage imageNamed:@"card-back.png"];
    self.showDelay=1;
    self.numOfCard =0;
    self.butGo.enabled=YES;
}

-(void) showNextCard{
    if(self.gameModel.gameStage == SJGameStageOver){
        //notify game is end.
        [self updateScore];
        [self.gameModel notifyGameDidEnd];
    }else if(self.gameModel.gameStage == SJGameStageContinue){
        //if gamestage is still continue, render card.
        //game not end, not continue, maybe someone click button or already bingo.
        SJCard *card = [self.gameModel nextCard];
        card.isFaceUp = YES;
        [self renderCards];
        if(self.numOfCard<51){
            self.numOfCard++;
        }else if (self.numOfCard==51){
            [self restartGame];
        }
    }
    if(self.gameModel.gameStage !=SJGameStageOver) {
        //when we get card, the speed should be fast than last card.
        [self.gameModel updateGameStage];
        self.showDelay-=0.004;
        [self performSelector:@selector(showNextCard) withObject:nil afterDelay:self.showDelay];
    }
}

-(void) updateScore{
    self.p1+=[self.gameModel getScore:1];
    self.p2+=[self.gameModel getScore:2];
    self.p3+=[self.gameModel getScore:3];
    self.p4+=[self.gameModel getScore:4];
    [self.pointP1 setText:[NSString stringWithFormat:@"%i",self.p1]];
    [self.pointP2 setText:[NSString stringWithFormat:@"%i",self.p2]];
    [self.pointP3 setText:[NSString stringWithFormat:@"%i",self.p3]];
    [self.pointP4 setText:[NSString stringWithFormat:@"%i",self.p4]];
    NSLog(@"%i",self.p1);
}

- (IBAction)butP1:(id)sender {
    if([self.gameModel isLastClick]<3)
        [self.gameModel updateClick:1];
}

- (IBAction)butP2:(id)sender {
    if([self.gameModel isLastClick]<3)
        [self.gameModel updateClick:2];
}

- (IBAction)butP3:(id)sender {
    if([self.gameModel isLastClick]<3)
        [self.gameModel updateClick:3];
}

- (IBAction)butP4:(id)sender {
    if([self.gameModel isLastClick]<3)
        [self.gameModel updateClick:4];
}

- (IBAction)butStart:(id)sender {
    self.butGo.enabled=NO;
    [self performSelector:@selector(showNextCard) withObject:nil afterDelay:self.showDelay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void) handleNotificationGameDidEnd:(NSNotification *)notification{
    NSString *message = @"Next Round!";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Go", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self restartGame];
}


@end
