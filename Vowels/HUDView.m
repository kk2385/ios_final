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
    
    
    
    //the stopwatch
    hud.stopwatch = [[StopwatchView alloc] initWithFrame: CGRectMake(kScreenWidth/2-150, 0, 300, 100)];
    hud.stopwatch.seconds = 0;
    [hud addSubview: hud.stopwatch];
    
    //"points" label//////////////////////////////////////////////////////////////////////////////
    hud.pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3,400,140,100)];
    hud.pointsLabel.backgroundColor = [UIColor clearColor];
    hud.pointsLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    hud.pointsLabel.text = @"Score :";
    hud.pointsLabel.textColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1.0];
    [hud addSubview:hud.pointsLabel];
    

    
    //game over label
    hud.gameOverLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,140,300,100)];
    hud.gameOverLabel.backgroundColor = [UIColor clearColor];
    hud.gameOverLabel.font = [UIFont fontWithName:@"GurmukhiMN " size:40];
      hud.gameOverLabel.textColor = [UIColor blackColor];
    hud.gameOverLabel.text = @"Game Over!";
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
    [hud.btnStart setTitle:@"Start" forState:UIControlStateNormal];
    hud.btnStart.titleLabel.font = kFontHUD;
    
    [hud.btnStart setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnStart.frame = CGRectMake(kScreenWidth/2.9, kScreenHeight/2-40, image.size.width/2, image.size.height/2);
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
    hud.helpTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/5, kScreenHeight/2-40,200,400)];
    hud.helpTextLabel.backgroundColor = [UIColor clearColor];
    hud.helpTextLabel.font = kFontHUD;
    hud.helpTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    hud.helpTextLabel.numberOfLines = 0;
    hud.helpTextLabel.text = @"Drag vowels to blank slots to complete the missing word";
    hud.helpTextLabel.textColor = [UIColor blueColor];
    hud.helpTextLabel.shadowColor = [UIColor blackColor];
    hud.helpTextLabel.shadowOffset = CGSizeMake(0, -1.0);
    [hud addSubview:hud.helpTextLabel];
    
    return hud;
}


-(void) makeAllHudElementsVisible {

    
    self.btnStart.alpha = 1;
    self.btnHelp.alpha = 1;
    self.btnReset.alpha = 1;
    self.highScoreLabel.alpha = 1;
    self.highScorePoints.alpha = 1;
    self.gameOverLabel.alpha = 1;
    self.stopwatch.alpha = 1;
    self.gamePoints.alpha = 1;
    self.pointsLabel.alpha = 1;
    self.helpTextLabel.alpha = 1;
}

-(void) makeAllHudElementsInvisible {
    
    self.btnStart.alpha = 0;
    self.btnHelp.alpha = 0;
    self.btnReset.alpha = 0;
    self.highScoreLabel.alpha = 0;
    self.highScorePoints.alpha = 0;
    self.gameOverLabel.alpha = 0;
    self.stopwatch.alpha = 0;
    self.gamePoints.alpha = 0;
    self.pointsLabel.alpha = 0;
    self.helpTextLabel.alpha = 0;
    
}

-(void) inGameMode {
    [self makeAllHudElementsInvisible];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnHelp.alpha = 1;
                         self.btnReset.alpha = 1;
                         self.stopwatch.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.gamePoints.alpha = 1;
                         self.pointsLabel.alpha = 1;
                     } completion:^(BOOL finished) {
                     }];
     self.backgroundColor = [UIColor clearColor];
    
}

-(void) inMenuMode {
    [self makeAllHudElementsInvisible];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnStart.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.helpTextLabel.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
   self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menub"]];
    

}

-(void) inEndGameMode {
    [self makeAllHudElementsInvisible];
    self.highScorePoints.text = [NSString stringWithFormat:@"%d", MAX(self.gamePoints.value, [self.highScorePoints.text integerValue])];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnStart.alpha = 1;
                         self.highScorePoints.alpha = 1;
                         self.highScoreLabel.alpha = 1;
                         self.gameOverLabel.alpha = 1;
                         self.gamePoints.alpha = 1;
                         self.pointsLabel.alpha = 1;
                        
                         
                         
                     } completion:^(BOOL finished) {
                         
                     }];
   
    //set the menu screen display image
     self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menub"]];
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