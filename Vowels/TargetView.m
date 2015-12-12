//
//  TargetView.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "TargetView.h"

@implementation TargetView

- (id)init
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

//create a new target, store what letter should it match to
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    UIImage* img = [UIImage imageNamed:@"slot"];
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
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0*scale];
        [self addSubview: lblChar];
        
        _letter = letter;
        _guess = letter;
    }
    return self;
}

@end
