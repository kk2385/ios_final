//
//  config.h
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//add more definitions here
#define kTileMargin 10
#define kFontHUD [UIFont fontWithName:@"Avenir" size:18]
#define kFontHUDBig [UIFont fontWithName:@"Avenir" size:40]
#define timerFont [UIFont fontWithName:@"Noteworthy-Bold" size:30]
#define countDownFont [UIFont fontWithName:@"Avenir" size:100]
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


#define kGameTime 15
#define configed 1
#endif