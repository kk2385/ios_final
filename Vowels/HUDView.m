//
//  HUDView.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "HUDView.h"
#import "config.h"

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
    UILabel* pts = [[UILabel alloc] initWithFrame:CGRectMake(2, -45,160,160)];
    pts.backgroundColor = [UIColor clearColor];
    pts.font = kFontHUD;
    pts.text = @" Points:";
    [hud addSubview:pts];
    
    hud.gameOverLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-310,kScreenHeight/2,140,70)];
    hud.gameOverLabel.backgroundColor = [UIColor clearColor];
    hud.gameOverLabel.font = kFontHUD;
    hud.gameOverLabel.text = @"Game Over!";
    [hud addSubview:hud.gameOverLabel];
    
    //the dynamic points label
    hud.gamePoints = [CounterLabelView labelWithFont:kFontHUD frame:CGRectMake(kScreenWidth-170,kScreenHeight/2,200,70) andValue:0];
    hud.gamePoints.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1] /*#611909*/;
    [hud addSubview: hud.gamePoints];
    
    
    //load the button image
    UIImage* image = [UIImage imageNamed:@"btn"];
    
    //the skip button///////////////////////////////////////////////////////////////////////////////
    hud.btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnHelp setTitle:@"Skip" forState:UIControlStateNormal];
    hud.btnHelp.titleLabel.font = kFontHUD;
    
    [hud.btnHelp setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnHelp.frame = CGRectMake(20, kScreenHeight/2-40, 80, 40);
    hud.btnHelp.alpha = 0.8;
    [hud addSubview: hud.btnHelp];
    
    //the start button///////////////////////////////////////////////////////////////////////////////
    hud.btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnStart setTitle:@"Start" forState:UIControlStateNormal];
    hud.btnStart.titleLabel.font = kFontHUD;
    
    [hud.btnStart setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnStart.frame = CGRectMake(50, kScreenHeight/2-40, image.size.width, image.size.height);
    hud.btnStart.alpha = 0.8;
    [hud addSubview: hud.btnStart];
    
    //the revert letters button
    hud.btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnReset setTitle:@"Reset Word" forState:UIControlStateNormal];
    hud.btnReset.titleLabel.font = kFontHUD;
    
    [hud.btnReset setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnReset.frame = CGRectMake(160, kScreenHeight/2-40, 145,40);
    hud.btnReset.alpha = 0.8;
    [hud addSubview: hud.btnReset];
    
    return hud;
}


-(void) makeAllHudElementsVisible {
    [self.btnStart setHidden: NO];
    [self.btnHelp setHidden: NO];
    [self.btnReset setHidden: NO];
    [self.stopwatch setHidden: NO];
    [self.gamePoints setHidden: NO];
    for (UIView *subview in self.subviews) { //selects all UILabels (gameover, points: highscore)
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview setHidden: NO];
        }
    }
    
    self.btnStart.alpha = 1;
    self.btnHelp.alpha = 1;
    self.btnReset.alpha = 1;
    self.stopwatch.alpha = 1;
    self.gamePoints.alpha = 1;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            subview.alpha = 1;
        }
    }
}

-(void) makeAllHudElementsInvisible {
    
    self.btnStart.alpha = 0;
    self.btnHelp.alpha = 0;
    self.btnReset.alpha = 0;
    self.stopwatch.alpha = 0;
    self.gamePoints.alpha = 0;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            subview.alpha = 0;
        }
    }
}

-(void) inGameMode {
    [self makeAllHudElementsVisible];
    [self makeAllHudElementsInvisible];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnStart.alpha = 0;
                         self.btnHelp.alpha = 1;
                         self.btnReset.alpha = 1;
                         self.stopwatch.alpha = 1;
                         self.gamePoints.alpha = 1;
                         for (UIView *subview in self.subviews) {
                             if ([subview isKindOfClass:[UILabel class]]) {
                                 subview.alpha = 1;
                             }
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void) inMenuMode {
    [self makeAllHudElementsVisible];
    [self makeAllHudElementsInvisible];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnStart.alpha = 1;
                         self.btnHelp.alpha = 0;
                         self.btnReset.alpha = 0;
                         self.stopwatch.alpha = 0;
                         self.gamePoints.alpha = 0;
                         for (UIView *subview in self.subviews) {
                             if ([subview isKindOfClass:[UILabel class]]) {
                                 subview.alpha = 0;
                             }
                         }
                     } completion:^(BOOL finished) {
                         
                     }];

}

-(void) inEndGameMode {
    [self makeAllHudElementsVisible];
    [self makeAllHudElementsInvisible];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btnStart.alpha = 1;
                         self.btnHelp.alpha = 0;
                         self.btnReset.alpha = 0;
                         self.stopwatch.alpha = 0;
                         self.gamePoints.alpha = 0;
                         for (UIView *subview in self.subviews) {
                             if ([subview isKindOfClass:[UILabel class]]) {
                                 subview.alpha = 0;
                             }
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
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