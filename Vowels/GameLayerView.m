//
//  GameLayerView.m
//  Vowels
//
//  Created by Jack Kwan on 12/12/15.
//  Copyright © 2015 nyu.edu. All rights reserved.
//

#import "GameLayerView.h"
#import "TileView.h"
#import "SlotView.h"

@implementation GameLayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // let touches through and only catch the ones on buttons
    UIView* hitView = (UIView*)[super hitTest:point withEvent:event];
    
    if ([hitView isKindOfClass:[TileView class]] || [hitView isKindOfClass:[SlotView class]] ||
        [hitView isKindOfClass:[UIButton class]]
        ) {
        return hitView;
    }
    
    return nil;
    
}


@end
