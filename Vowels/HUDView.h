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

@interface HUDView : UIView

@property (strong, nonatomic) StopwatchView* stopwatch;
@property (strong, nonatomic) CounterLabelView* gamePoints;
@property (strong, nonatomic) UILabel* pointsLabel;
@property (strong, nonatomic) UILabel* highScoreLabel;
@property (strong, nonatomic) UILabel* highScorePoints;
@property (strong, nonatomic) UILabel* gameOverLabel;
//@property (strong, nonatomic) UIView* menuScreen;

@property (strong, nonatomic) UIButton* btnHelp;
@property (strong, nonatomic) UIButton* btnStart;
@property (strong, nonatomic) UIButton* btnReset;


+(instancetype)viewWithRect:(CGRect)r;

-(void) inGameMode;
-(void) inMenuMode;
-(void) inEndGameMode;

@end
