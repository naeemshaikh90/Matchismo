//
//  Card.m
//  Matchismo
//
//  Created by Naeem Shaikh on 27/08/16.
//  Copyright © 2016 Naeem G Shaikh. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

//match: is going to return a “score” which says how good a match the passed card is to the Card that is receiving this message.
// 0 means “no match”, higher numbers mean a better match.

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
