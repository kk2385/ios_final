//
//  AudioController.h
//

#import <Foundation/Foundation.h>

@interface AudioController : NSObject

-(void)playEffect:(NSString*)name;
-(void)preloadAudioEffects:(NSArray*)effectFileNames;

@end
