//
//  HUDView.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "HUDView.h"
#import "config.h"
#import <QuartzCore/QuartzCore.h>

@implementation HUDView

+(instancetype)viewWithRect:(CGRect)r
{
    //create the hud layer
    HUDView* hud = [[HUDView alloc] initWithFrame:r];
    hud.userInteractionEnabled = YES;
    
    UIImage* logoImage = [UIImage imageNamed: @"logoSmall.png"];
    hud.logo = [[UIImageView alloc] initWithImage: logoImage];
    hud.logo.frame = CGRectMake(kScreenWidth/6, kScreenHeight/8, 230, 230);
    hud.btnStart.center = CGPointMake(hud.center.x, hud.center.y-kScreenHeight/5);
    [hud addSubview: hud.logo];
    
    //the stopwatch
    hud.stopwatch = [[StopwatchView alloc] initWithFrame: CGRectMake(kScreenWidth/2-150, 0, 300, 100)];
    hud.stopwatch.seconds = 0;
    [hud addSubview: hud.stopwatch];
    
    //the countdown
    hud.countdown = [[CountDownView alloc] initWithFrame: CGRectMake(kScreenWidth/2, kScreenHeight/2, 100, 100)];
    hud.countdown.seconds = 3;
    [hud addSubview: hud.countdown];
    
    //"points" label//////////////////////////////////////////////////////////////////////////////
    hud.pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3,400,140,100)];
    hud.pointsLabel.backgroundColor = [UIColor clearColor];
    hud.pointsLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    hud.pointsLabel.text = @"Score :";
    hud.pointsLabel.textColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1.0];
    [hud addSubview:hud.pointsLabel];
    

    
    //game over label
    hud.gameOverLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,-10,400,400)];
    hud.gameOverLabel.backgroundColor = [UIColor clearColor];
    hud.gameOverLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:50];
    hud.gameOverLabel.textColor = [UIColor blackColor];
    hud.gameOverLabel.text = @"Game Over!";
    
//    
//    UIGraphicsBeginImageContext(hud.gameOverLabel.frame.size);
//    [[UIImage imageNamed:@"jgo.png"] drawInRect:hud.gameOverLabel.bounds];
//    UIImage *images = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    hud.gameOverLabel.backgroundColor = [UIColor colorWithPatternImage:images];
    [hud addSubview:hud.gameOverLabel];
    
    //high score label
    hud.highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 25,117,30)];
    hud.highScoreLabel.backgroundColor = [UIColor colorWithRed:0.18 green:0.58 blue:0.79 alpha:1.0];
    hud.highScoreLabel.layer.masksToBounds = YES;
    hud.highScoreLabel.layer.cornerRadius = 8;
    
    hud.highScoreLabel.font = kFontHUD;
    hud.highScoreLabel.text = @" High Score:";
    hud.highScoreLabel.textColor = [UIColor whiteColor];
//     hud.highScoreLabel.shadowColor = [UIColor blackColor];
//     hud.highScoreLabel.shadowOffset = CGSizeMake(0, -1.0);
    
    [hud addSubview:hud.highScoreLabel];
    
    //high score points label
    hud.highScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(112, 25,110,30)];
    hud.highScorePoints.backgroundColor = [UIColor clearColor];
    hud.highScorePoints.font = kFontHUD;
    hud.highScorePoints.text = @"0";
    hud.highScorePoints.layer.zPosition = 1;
    hud.highScorePoints.textColor = [UIColor whiteColor];
    [hud addSubview:hud.highScorePoints];
    [hud bringSubviewToFront:hud.highScorePoints];


    //the dynamic points label
    hud.gamePoints = [CounterLabelView labelWithFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:35] frame:CGRectMake(kScreenWidth/1.6,400,140,100) andValue:0];
    hud.gamePoints.textColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1.0];
    [hud addSubview: hud.gamePoints];
    
    
    //load the button image
    UIImage* image = [UIImage imageNamed:@"nb.png"];
    
    //the skip button///////////////////////////////////////////////////////////////////////////////
    hud.btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnHelp setTitle:@"Skip" forState:UIControlStateNormal];
    hud.btnHelp.titleLabel.font = kFontHUD;
    
    [hud.btnHelp setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnHelp.frame = CGRectMake(20, 500, 80, 40);
    hud.btnHelp.alpha = 0.8;
    [hud addSubview: hud.btnHelp];
    
    //the start button///////////////////////////////////////////////////////////////////////////////
    hud.btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnStart setTitle:@"PLAY" forState:UIControlStateNormal];
    hud.btnStart.titleLabel.font = [UIFont fontWithName:@"Avenir" size:40];
    
    [hud.btnStart setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnStart.frame = CGRectMake(kScreenWidth/2.8, kScreenHeight/1.7, image.size.width/1.3, image.size.height/1.3);
    hud.btnStart.center = CGPointMake(hud.center.x, hud.center.y+kScreenHeight/7.5);
    hud.btnStart.alpha = 0.8;
    [hud addSubview: hud.btnStart];
    
    //the revert letters button
    hud.btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnReset setTitle:@"Reset Word" forState:UIControlStateNormal];
    hud.btnReset.titleLabel.font = kFontHUD;
    
    [hud.btnReset setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnReset.frame = CGRectMake(160, 500, 145,40);
    hud.btnReset.alpha = 0.8;
    [hud addSubview: hud.btnReset];
    
    
    //help text label
    hud.helpTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/6.5, kScreenHeight/2-40,240,400)];
    hud.helpTextLabel.backgroundColor = [UIColor clearColor];
    hud.helpTextLabel.font = [UIFont fontWithName:@"Avenir" size:25];
    hud.helpTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    hud.helpTextLabel.numberOfLines = 0;
    hud.helpTextLabel.textAlignment = NSTextAlignmentCenter;
    hud.helpTextLabel.text = @"Drag vowels to blank slots to complete the missing word";
    hud.helpTextLabel.textColor = [UIColor blackColor];
   // hud.helpTextLabel.shadowColor = [UIColor blackColor];
    hud.helpTextLabel.shadowOffset = CGSizeMake(0, -1.0);
    hud.helpTextLabel.center = CGPointMake(hud.center.x, hud.center.y+kScreenHeight/3);

    [hud addSubview:hud.helpTextLabel];
    
    return hud;
}


-(void) makeAllHudElementsVisible {

    self.logo.alpha = 1;
    self.btnStart.alpha = 1;
    self.btnHelp.alpha = 1;
    self.btnReset.alpha = 1;
    self.highScoreLabel.alpha = 1;
    self.highScorePoints.alpha = 1;
    self.gameOverLabel.alpha = 1;
    self.stopwatch.alpha = 1;
    self.countdown.alpha = 1;
    self.gamePoints.alpha = 1;
    self.pointsLabel.alpha = 1;
    self.helpTextLabel.alpha = 1;
}

-(void) makeAllHudElementsInvisible {
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.logo.alpha = 0;
                         self.btnStart.alpha = 0;
                         self.btnHelp.alpha = 0;
                         self.btnReset.alpha = 0;
                         self.highScoreLabel.alpha = 0;
                         self.highScorePoints.alpha = 0;
                         self.gameOverLabel.alpha = 0;
                         self.stopwatch.alpha = 0;
                         self.countdown.alpha = 0;
                         self.gamePoints.alpha = 0;
                         self.pointsLabel.alpha = 0;
                         self.helpTextLabel.alpha = 0;
                     } completion:^(BOOL finished) {
                     }];
}

-(void) inGameMode {
    [self makeAllHudElementsInvisible];
    self.gamePoints.center = CGPointMake(self.center.x+kScreenWidth/3.5+10, self.center.y+kScreenHeight/3.3);
    self.pointsLabel.center = CGPointMake(self.center.x+10, self.center.y+kScreenHeight/3.3);
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.btnHelp.alpha = 1;
                         self.btnReset.alpha = 1;
                         self.stopwatch.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.gamePoints.alpha = 1;
                         self.gamePoints.center = CGPointMake(self.center.x+kScreenWidth/3.5+10, self.center.y+kScreenHeight/3.3);
                         self.pointsLabel.alpha = 1;
                         self.pointsLabel.center = CGPointMake(self.center.x+10, self.center.y+kScreenHeight/3.3);
                     } completion:^(BOOL finished) {
                     }];
     self.backgroundColor = [UIColor clearColor];
    
}

-(void) inCountDownMode {
    [self makeAllHudElementsInvisible];
    
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.countdown.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mmj.jpg"]];
}

-(void) inMenuMode {
    [self makeAllHudElementsInvisible];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.logo.alpha = 1;
                         self.btnStart.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.helpTextLabel.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
//   self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mmj.jpg"]];
    

}

-(void) inEndGameMode {
    [self makeAllHudElementsInvisible];
    self.highScorePoints.text = [NSString stringWithFormat:@"%d", MAX(self.gamePoints.value, [self.highScorePoints.text integerValue])];
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.btnStart.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.gameOverLabel.alpha = 1;
                         self.gamePoints.alpha = 1;
                         self.gamePoints.center = CGPointMake(self.center.x+10+kScreenWidth/3.5, self.center.y);
                         self.pointsLabel.alpha = 1;
                         self.pointsLabel.center = CGPointMake(self.center.x+10, self.center.y);
                     } completion:^(BOOL finished) {
                         
                     }];
   
    //set the menu screen display image
//     self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"strscreen.jpg"]];
   
}


-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // let touches through and only catch the ones on buttons
    UIView* hitView = (UIView*)[super hitTest:point withEvent:event];
    
    if ([hitView isKindOfClass:[UIButton class]]) {
        return hitView;
    }
    
    return nil;
    
}

@end