//
//  HUDView.h
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopwatchView.h"
#import "CounterLabelView.h"
#import "CountDownView.h"


@interface HUDView : UIView

@property (strong, nonatomic) UIImageView* logo;
@property (strong, nonatomic) StopwatchView* stopwatch;
@property (strong, nonatomic) CountDownView* countdown;
@property (strong, nonatomic) CounterLabelView* gamePoints;
@property (strong, nonatomic) UILabel* pointsLabel;
@property (strong, nonatomic) UILabel* highScoreLabel;
@property (strong, nonatomic) UILabel* highScorePoints;
@property (strong, nonatomic) UILabel* gameOverLabel;
//@property (strong, nonatomic) UIView* menuScreen;

@property (strong, nonatomic) UIButton* btnHelp;
@property (strong, nonatomic) UIButton* btnStart;
@property (strong, nonatomic) UIButton* btnReset;

@property (strong, nonatomic) UILabel* helpTextLabel;

+(instancetype)viewWithRect:(CGRect)r;

-(void) inCountDownMode;
-(void) inGameMode;
-(void) inMenuMode;
-(void) inEndGameMode;

@end
