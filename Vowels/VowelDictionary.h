//
//  VowelDictionary.h
//  dictionary-vowels
//
//  Created by Jack Kwan on 12/7/15.
//  Copyright © 2015 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VowelDictionary : NSObject

@property (retain, nonatomic) NSMutableDictionary *dict;

+ (instancetype)DictionaryWithWords;

- (id)initWithEmptyDictionary;

- (void)addToDictionary: (NSString *)word;

- (NSString *)getRandomWord;

- (BOOL)isADictionaryWord: (NSString *)word;

- (NSString *)stripVowels: (NSString *)word;

- (BOOL)isVowel: (NSString *)lowerCaseLetter;

@end
