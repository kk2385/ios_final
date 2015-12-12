//
//  GameController.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameController.h"
#import "config.h"
#import "TileView.h"
#import "TargetView.h"
#import "ExplodeView.h"
#import "StarDustView.h"

@implementation GameController
{
    //tile lists
    NSMutableArray* _tiles;
    NSMutableArray* _tilesBottom; //the bottom of an AEIOU block.
    NSMutableArray* _targets;
    
    //stopwatch variables
    int _secondsLeft;
    NSTimer* _timer;
}

//initialize the game controller
-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
        self.data = [[GameData alloc] init];
        self.dict = [VowelDictionary DictionaryWithWords];
        self.audioController = [[AudioController alloc] init];
        [self.audioController preloadAudioEffects: kAudioEffectFiles];
        
        //start the timer
//        [self startStopwatch];
    }
    return self;
}

//fetches a random anagram, deals the letter tiles and creates the targets
-(void)dealRandomAnagram
{
    //random word
    NSString* vowelWord = [self.dict getRandomWord];
    int vowelWordLength = [vowelWord length];
    
    NSLog(@"vowel word: length:%i %@", vowelWordLength, vowelWord);

    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.9 / (float)(vowelWordLength) ) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenWidth - (vowelWordLength) * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead the tile's origin)
    xOffset += tileSide/2;
    
    // initialize target list
    _targets = [NSMutableArray arrayWithCapacity: vowelWordLength];
    
    // create targets
    for (int i=0;i<vowelWordLength;i++) {
        NSString* letter = [vowelWord substringWithRange:NSMakeRange(i, 1)];
        if ([self.dict isVowel: letter]) {
            letter = @" ";
        }
        TargetView* target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
        target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4);
        
        [self.gameView addSubview:target];
        [_targets addObject: target];
    }
    
    //initialize tile list
    _tiles = [NSMutableArray arrayWithCapacity: 50];
    _tilesBottom = [NSMutableArray arrayWithCapacity: 5];

    
    NSString* vowels = @"aeiou";
    
    tileSide = ceilf( kScreenWidth*0.9 / (float)([vowels length]) ) - kTileMargin;
    xOffset = (kScreenWidth - ([vowels length]) * (tileSide + kTileMargin))/2;
    xOffset += tileSide/2;

    //create tiles and tilesBottoms
    for (int i=0;i<[vowels length];i++) {
        NSString* letter = [vowels substringWithRange:NSMakeRange(i, 1)];
        TargetView* bottom = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
        bottom.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4*3);
        [self.gameView addSubview:bottom];
        [_tilesBottom addObject: bottom];
    }
    [self generateLetterTile:@"a"];
    [self generateLetterTile:@"e"];
    [self generateLetterTile:@"i"];
    [self generateLetterTile:@"o"];
    [self generateLetterTile:@"u"];

    
    
//    //start the timer
//    [self startStopwatch];
}

//a tile was dragged, check if matches a target
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt
{
    TargetView* targetView = nil;
    
    for (TargetView* tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt) && [tv.letter isEqualToString:@" "]) {
            targetView = tv;
            break;
        }
    }
    [self printAllTiles];
    // check if target was found
    if (targetView!=nil) {
        
        // check if letter matches
//        if ([targetView.letter isEqualToString: tileView.letter]) {
        
        [self placeTile:tileView atTarget:targetView];
        
        //more stuff to do on success here
        [self.audioController playEffect: kSoundDing];
        
        //give points
//        self.data.points += self.level.pointsPerTile;
        [self.hud.gamePoints countTo:self.data.points withDuration:1.5];
        
        //check for finished game
        [self checkForSuccess];
    } else {
        [self actionRevertVowel: tileView];
    }
//        }
//        } else {
//
//            //visualize the mistake
//            [tileView randomize];
//            
//            [UIView animateWithDuration:0.35
//                                  delay:0.00
//                                options:UIViewAnimationOptionCurveEaseOut
//                             animations:^{
//                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
//                                                               tileView.center.y + randomf(20, 30));
//                             } completion:nil];
//            
//            //more stuff to do on failure here
//            [self.audioController playEffect:kSoundWrong];
//            
//            //take out points
//            self.data.points -= self.level.pointsPerTile/2;
//            [self.hud.gamePoints countTo:self.data.points withDuration:.75];
//        }
}

-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    targetView.isMatched = YES;
    tileView.isMatched = YES;
    targetView.guess = tileView.letter;
    
    [self printGuessStatus];
    
    NSLog(@"PLACED TILE! Current guess: %@", [self getCurrentGuess]);
    tileView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tileView.center = targetView.center;
                         tileView.transform = CGAffineTransformIdentity;
                         float scale = targetView.frame.size.height / tileView.frame.size.height;
                         tileView.transform = CGAffineTransformScale(tileView.transform, scale, scale);
                     }
                     completion:^(BOOL finished){
                         targetView.hidden = NO;
                     }];
    
//    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x,tileView.center.y,10,10)];
//    [tileView.superview addSubview: explode];
//    [tileView.superview sendSubviewToBack:explode];
    
    //generaete a new tile in case the same letter needs to be used again.
    [self generateLetterTile: tileView.letter];
}

-(void)checkForSuccess
{
    for (TargetView* t in _targets) {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    NSLog(@"Game Over!");
    
    BOOL correct = [self.dict isADictionaryWord:[self getCurrentGuess]];
    
    NSLog(correct? @"CORRECT" : @"WRONG");
    
    if (!correct) {
        [self revertAllTiles];
        return;
    } else {
        self.data.points += 1;
        [self.hud.gamePoints countTo: self.data.points withDuration: 1.5];
        [self clearBoard];
        [self dealRandomAnagram];
        return;
    
    }
    
    //stop the stopwatch
    [self stopStopwatch];
    
    //the anagram is completed!
    [self.audioController playEffect:kSoundWin];
    
    //win animation
    TargetView* firstTarget = _targets[0];
    
    int startX = 0;
    int endX = kScreenWidth + 300;
    int startY = firstTarget.center.y;
    
    StarDustView* stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.gameView addSubview:stars];
    [self.gameView sendSubviewToBack:stars];
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         stars.center = CGPointMake(endX, startY);
                     } completion:^(BOOL finished) {
                         
                         //game finished
                         [stars removeFromSuperview];
                         
                         //when animation is finished, show menu
                         [self clearBoard];
                         self.onAnagramSolved();
                     }];
}

-(NSString*) getCurrentGuess
{
    NSString *result = @"";
    for (TargetView* t in _targets) {
        result = [result stringByAppendingString:t.guess];
    }
    return result;
}

-(void) printGuessStatus
{
    for (TargetView* t in _targets) {
        NSString *flag = t.isMatched ? @"Yes" : @"No";
        NSLog(@"%@: %@", t.guess, flag);
    }
}

-(void) printAllTiles
{
    NSLog(@"MY TILES...");
    int count = 0;
    for (TileView* t in _tiles) {
        NSString *flag = t.isMatched ? @"Yes" : @"No";
        NSLog(@"CURRENT tile%@: matched: %@", t.letter, flag);
        count++;
    }
    NSLog(@"%d blocks counted", count);
}

-(void)startStopwatch
{
    //initialize the timer HUD
    _secondsLeft = kGameTime;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    //schedule a new timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(tick:)
                                            userInfo:nil
                                             repeats:YES];
}

//stop the watch
-(void)stopStopwatch
{
    [_timer invalidate];
    _timer = nil;
    [self clearBoard];
    [self.hud inEndGameMode];
    
}

//stopwatch on tick
-(void)tick:(NSTimer*)timer
{
    _secondsLeft --;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    if (_secondsLeft==0) {
        [self stopStopwatch];
    }
}

//connect the Hint button
-(void)setHud:(HUDView *)hud
{
    _hud = hud;
    [hud.btnHelp addTarget:self action:@selector(actionHint) forControlEvents:UIControlEventTouchUpInside];
    [hud.btnStart addTarget:self action:@selector(actionStart) forControlEvents:UIControlEventTouchUpInside];

}


-(void) actionStart
{
    [_hud inGameMode];
    [self revertAllTiles];
    [self clearBoard];
    [self startStopwatch];
    [self dealRandomAnagram];
}

//the user pressed the hint button
-(void)actionHint
{
    [self revertAllTiles];
    [self clearBoard];
    [self dealRandomAnagram];
//    self.hud.btnHelp.enabled = NO;
//    
//    self.data.points -= self.level.pointsPerTile/2;
//    [self.hud.gamePoints countTo: self.data.points withDuration: 1.5];
//    
//    // find the first target, not matched yet
//    TargetView* target = nil;
//    for (TargetView* t in _targets) {
//        if (t.isMatched==NO) {
//            target = t;
//            break;
//        }
//    }
//    
//    // find the first tile, matching the target
//    TileView* tile = nil;
//    for (TileView* t in _tiles) {
//        if (t.isMatched==NO && [t.letter isEqualToString:target.letter]) {
//            tile = t;
//            break;
//        }
//    }
//    
//    // don't want the tile sliding under other tiles
//    [self.gameView bringSubviewToFront:tile];
//    
//    //show the animation to the user
//    [UIView animateWithDuration:1.5
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         tile.center = target.center;
//                     } completion:^(BOOL finished) {
//                         // adjust view on spot
//                         [self placeTile:tile atTarget:target];
//                         
//                         // check for finished game
//                         [self checkForSuccess];
//                         
//                         // re-enable the button
//                         self.hud.btnHelp.enabled = YES;
//                     }];
    
}


// revert a tile back to its original stack.
-(void)actionRevertVowel: (TileView*)tile
{
    // find the first target, not matched yet
    TargetView* target = nil;
    for (TargetView* t in _tilesBottom) {
        if ([t.letter isEqualToString:tile.letter]) {
            target = t;
            break;
        }
    }
    
    // don't want the tile sliding under other tiles
    [self.gameView bringSubviewToFront:tile];
    
    //show the animation to the user
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tile.center = target.center;
                     } completion:^(BOOL finished) {
                         // adjust view on spot
//                         [self placeTile:tile atTarget:target];
                     }];
    
}

//when a guess is wrong all the tiles on the guess revert back to the bottom.
-(void) revertAllTiles
{
    for (TileView* tile in _tiles) {
        if (tile.isMatched) {
            // find the first target, not matched yet
            TargetView* target = nil;
            for (TargetView* t in _tilesBottom) {
                if ([t.letter isEqualToString:tile.letter]) {
                    target = t;
                    break;
                }
            }
            
            // don't want the tile sliding under other tiles
            [self.gameView bringSubviewToFront:tile];
            
            //show the animation to the user
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tile.center = target.center;
                                 tile.transform = CGAffineTransformIdentity;
                                 float scale = target.frame.size.height / tile.frame.size.height;
                                 tile.transform = CGAffineTransformScale(tile.transform, scale, scale);
                             } completion:^(BOOL finished) {
                                 [tile removeFromSuperview];
                                 [_tiles removeObject:tile];
                                 [self setTargetTilesToUnmatched];
                             }];
        }
    }
}

-(void) generateLetterTile: (NSString*) letter {
    // find the corresponding first letter bottom
    TargetView* target = nil;
    for (TargetView* t in _tilesBottom) {
        if ([t.letter isEqualToString:letter]) {
            target = t;
            break;
        }
    }
    
    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.9 / (float)(5) ) - kTileMargin;
    TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
    tile.center = target.center;
    tile.dragDelegate = self;
    
    [_tiles addObject: tile];
    [self.gameView addSubview:tile];
    
    tile.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^() {
        tile.alpha = 1.0f;
    }];
}

-(void) setTargetTilesToUnmatched {
    for (TargetView* t in _targets) {
        if ([t.letter isEqualToString:@" "]) {
            t.guess = @" ";
            t.isMatched = NO;
        }
    }
}

//clear the tiles and targets
-(void)clearBoard
{
    [_tiles removeAllObjects];
    [_targets removeAllObjects];
    
    for (UIView *view in self.gameView.subviews) {
        [view removeFromSuperview];
    }
}

@end
