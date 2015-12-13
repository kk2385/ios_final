//
//  config.h
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//add more definitions here
#define kTileMargin 10
#define kFontHUD [UIFont fontWithName:@"Papyrus " size:38]
#define kFontHUDBig [UIFont fontWithName:@"Papyrus " size:38]

//audio defines
#define dragTileSound  @"plop.mp3"
#define incorrectSound @"badL.wav"
#define kSoundWin   @"correct.aiff"
#define wrongWord @"wrongWord.wav"
#define clickSound @"clickSound.wav"
#define startSound @"startSound.wav"
#define timerEnding @"timerEnding.wav"

#define kAudioEffectFiles @[dragTileSound, incorrectSound, kSoundWin, wrongWord, clickSound,startSound, timerEnding]

//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)


#define kGameTime 8
#define configed 1
#endif