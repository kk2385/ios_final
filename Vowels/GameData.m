//
//  GameData.m
//

#import "GameData.h"

@implementation GameData

//custom setter - keep the score positive
-(void)setPoints:(int)points
{
  _points = MAX(points, 0);
}

@end
