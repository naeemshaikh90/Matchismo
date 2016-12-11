//
//  ViewController.m
//  Matchismo
//
//  Created by Naeem Shaikh on 27/08/16.
//  Copyright © 2016 Naeem G Shaikh. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (CardMatchingGame *)restartGame
{
    if (_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        [self updateUI];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

#pragma mark - IBAction
- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

/*
 Assignment 2: Matchismo 2
 2] - Add a button which will re-deal all of the cards (i.e. start a new game). It should reset the score (and anything else in the UI that makes sense). In a real game, we’d probably want to ask the user if he or she is “sure” before aborting the game in process to re-deal, but for this assignment, you can assume the user always knows what he or she is doing when they hit this button.
 */
- (IBAction)restartGameButton:(UIButton *)sender {
    
    [self restartGame];
}

/*
 Assignment 2: Matchismo 2
 3] - Drag out a switch (UISwitch) or a segmented control (UISegmentedControl) into your View somewhere which controls whether the game matches two cards at a time or three cards at a time (i.e. it sets “2-card-match mode” vs. “3-card-match mode”). Give the user appropriate points depending on how difficult the match is to accomplish. In 3-card-match mode, it should be possible to get some (although a significantly lesser amount of) points for picking 3 cards of which only 2 match in some way. In that case, all 3 cards should be taken out of the game (even though only 2 match). In 3-card-match mode, choosing only 2 cards is never a match.
 */
- (IBAction)gameModeButton:(UISegmentedControl *)sender {
    
}

#pragma mark - updateUI
- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        // If a card.isMatched, we can disable the corresponding cardButton
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld",(long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end

