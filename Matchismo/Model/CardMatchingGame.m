//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Naeem Shaikh on 28/08/16.
//  Copyright © 2016 Naeem G Shaikh. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSUInteger *score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

// Lazy instantiation!
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated initializer
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    // check to be sure the argument is not out of bounds.
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    /* We will only allow unmatched cards to be chosen
    (i.e. once a card is matched, it’s “out of the game”). */
    
    if (!card.isMatched) {
        
        if (card.isChosen) {
            
            /* If the card is already chosen, we’ll “unchoose” it
             (so really this method is more like “toggle chosen state of card”). */
            card.chosen = NO;
            
        } else {
            // match against other chosen cards.
            
            for (Card *otherCard in self.cards) {
                
                /* We’ll just iterate through all the cards in the game, looking for ones that are unmatched and already chosen. */
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    /* If we find another chosen, unmatched card, we check to see if it matches the just chosen card using Card's match: method. */
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        
                        // If there’s a match (of any kind) ,bump our score!
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        
                        // Otherwise, impose a penalty for choosing mismatching cards.
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; // can only choose 2 cards of now.
                }
            }
            
            // Let’s making choosing cards not be “free” by imposing a cost to choose.
            self.score += COST_TO_CHOOSE;
            
            card.chosen = YES;
        }
    }
}

@end

