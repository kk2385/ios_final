//
//  TargetView.h
//

#import <UIKit/UIKit.h>

@interface SlotView : UIImageView

@property (strong, nonatomic, readonly) NSString* letter;
@property (strong, nonatomic) NSString* guess;
@property (assign, nonatomic) BOOL isMatched;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;

@end
