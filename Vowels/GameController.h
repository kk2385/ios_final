//
//  GameController.h
//

#import <Foundation/Foundation.h>
#import "TileView.h"
#import "HUDView.h"
#import "GameData.h"
#import "AudioController.h"
#import "VowelDictionary.h"

typedef void (^CallbackBlock)();

@interface GameController : NSObject <TileDragDelegateProtocol>

//the view to add game elements to
@property (weak, nonatomic) UIView* gameView;

//the current level
@property (weak, nonatomic) HUDView* hud;

@property (strong, nonatomic) GameData* data;

@property (strong, nonatomic) AudioController* audioController;

@property (strong, nonatomic) CallbackBlock onAnagramSolved;

@property (strong, nonatomic) VowelDictionary* dict;

@property int secondsLeft;

//display a new anagram on the screen
-(void) showRandomWord;
-(void) actionReset;
-(BOOL) inGame;

@end
