//
//  StopwatchView.m
//

#import "StopwatchView.h"
#import "config.h"

@implementation StopwatchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];//stopwatch position
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.font = timerFont;
        self.textColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.0f;
        
    }
    return self;
}

//helper method that implements time formatting
//to an int parameter (eg the seconds left)
-(void)setSeconds:(int)seconds
{
    if (seconds <= 5) {
        self.textColor = [UIColor redColor];
    } else {
        self.textColor = [UIColor whiteColor];
    }
    self.text = [NSString stringWithFormat:@" %02.f : %02i", round(seconds / 60), seconds % 60 ];
}

@end
