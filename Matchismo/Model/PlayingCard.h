//
//  PlayingCard.h
//  Matchismo
//
//  Created by Naeem Shaikh on 27/08/16.
//  Copyright © 2016 Naeem G Shaikh. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

//We’ll represent the suit as an NSString that simply contains a single character corresponding to the suit
//(i.e. one of these characters: ♠♣♥♦).
//If this property is nil, it’ll mean “suit not set”.
@property (strong, nonatomic) NSString *suit;

//We’ll represent the rank as an integer from
//0 (rank not set) to 13 (a King).
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
