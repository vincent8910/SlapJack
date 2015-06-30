//
//  ViewController.h
//  SlapJack
//
//  Created by VincentChen on 2015/5/13.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>{
    AVAudioPlayer *audioPlayer;
}

@property (weak, nonatomic) IBOutlet UIImageView *TableCard;
@property (weak, nonatomic) IBOutlet UILabel *pointP1;
@property (weak, nonatomic) IBOutlet UILabel *pointP2;
@property (weak, nonatomic) IBOutlet UILabel *pointP3;
@property (weak, nonatomic) IBOutlet UILabel *pointP4;
@property (weak, nonatomic) IBOutlet UIButton *butGo;
@property (nonatomic) int p1,p2,p3,p4;
//Score of p1,p2,p3,p4
@property (nonatomic) double showDelay;
//Delay of render cards
@property (nonatomic) NSString *filePath;
@property (nonatomic) NSData *fileData;
//Mp3 player

- (IBAction)butP1:(id)sender;
- (IBAction)butP2:(id)sender;
- (IBAction)butP3:(id)sender;
- (IBAction)butP4:(id)sender;
- (IBAction)butStart:(id)sender;

- (void) viewWillAppear:(BOOL)animated;
- (id) initWithCoder:(NSCoder *)aDecoder;
- (void) renderCards;
- (void) restartGame;
- (void) showNextCard;
- (void) updateScore;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void) handleNotificationGameDidEnd:(NSNotification *)notification;

@end

