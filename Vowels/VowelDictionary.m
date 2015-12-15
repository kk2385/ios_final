//
//  VowelDictionary.m
//  dictionary-vowels
//
//  Created by Jack Kwan on 12/7/15.
//  Copyright © 2015 nyu.edu. All rights reserved.
//

#import "VowelDictionary.h"

@implementation VowelDictionary

@synthesize dict = _dict;    // Optional for Xcode 4.4+

+(instancetype)DictionaryWithWords
{
    VowelDictionary *dict = [[VowelDictionary alloc] initWithEmptyDictionary];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"words"
                                                     ofType:@"txt"];
    
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSArray *array = [content componentsSeparatedByCharactersInSet:
                      [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    for (int i = 0; i < array.count; i++) {
        NSString *curr = array[i];
        if ([curr length] >= 4 && [curr length] <= 7)  {
            [dict addToDictionary:array[i]];
        }
    }
    return dict;
}

- (id)initWithEmptyDictionary {
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)addToDictionary: (NSString *)word {
    _dict[word] = @1;
}

- (NSString *)getRandomWord {
    NSArray *array = [_dict allKeys];
    int random = arc4random()%[array count];
    NSString *key = [array objectAtIndex:random];
    return key;
}

- (BOOL)isADictionaryWord: (NSString *)word {
    return [_dict objectForKey:word] != nil;
}

- (NSString *)stripVowels: (NSString *)word {
    NSMutableString *result = [NSMutableString stringWithCapacity:10000];
    NSUInteger len = [word length];
    unichar buffer[len];
    
    [word getCharacters:buffer range:NSMakeRange(0, len)];
    
    for (int i = 0; i < len; ++i) {
        char current = buffer[i];
//        NSLog(@"current char: %c", current);
        if ([@"aeiou" rangeOfString:[NSString stringWithFormat:@"%c", current]].location == NSNotFound) {
            [result appendFormat:@"%c", current];
//            NSLog(@"    Adding %c...", current);
        }
    }
    return result;
}

- (BOOL)isVowel: (NSString *)lowerCaseLetter {
    return [@"aeiou" rangeOfString:lowerCaseLetter].location != NSNotFound;
}

@end
