//
//  ViewController.m
//  TestProject
//
//  Created by Geraldine Forto on 03/10/2016.
//  Copyright © 2016 Geraldine Forto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  NSInteger score;
  NSInteger round;
  int target;

}
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

const int maxValue = 100;
const int minValue = 1;

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self reset];
  [self setValues];
  [self.slider setThumbImage:[UIImage imageNamed:@"SliderThumb-Normal.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)hitMeButtonPressed:(id)sender {
  int difference = target - (int)self.slider.value;
  if (difference < 0){
    difference *= -1;
  }
  
  if (difference <= 10) {
    score += (10 - difference);
    round++;
  } else {
    [self reset];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Sorry, you lose!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okayButton];
    [self presentViewController:alert animated:YES completion:nil];
  }
  
  [self setValues];
}

- (IBAction)startOverButtonPressed:(id)sender {
  [self reset];
  [self setValues];
}

- (IBAction)infoButtonPressed:(id)sender {
  
}

- (void) reset {
  score = 0;
  round = 0;
}

- (void) setValues {
  target = arc4random_uniform(100);
  self.instructionLabel.text = [NSString stringWithFormat:@"Put the Bull's Eye as close as you can to : %d", target];
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld", (long)score];
  self.roundLabel.text = [NSString stringWithFormat:@"Round : %ld", (long)round];
}

@end
