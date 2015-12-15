//
//  TargetView.m
//

#import "SlotView.h"

@implementation SlotView

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    UIImage* img = [UIImage imageNamed:@"constonant"];
    self = [super initWithImage: img];
    
    if (self != nil) {
        //initialization
        if ([letter isEqualToString:@" "]) {
            self.isMatched = NO;
        } else {
            self.isMatched = YES;
        }
        
        
        
        float scale = sideLength/img.size.width;
        
        
        self.frame = CGRectMake(0,0,img.size.width*scale, img.size.height*scale);
        
        //add a letter on top
        UILabel* lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor blackColor];
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.text = [letter uppercaseString];
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:50.0*scale];
        [self addSubview: lblChar];
        
        _letter = letter;
        _guess = letter;
    }
    return self;
}

@end
