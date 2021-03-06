//
//  ViewController.m
//  TV-TVAnimationRadar
//
//  Created by John M. P. Knox on 11/27/15.
//  Copyright © 2015 John M. P. Knox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *animatedView;
@property (assign, nonatomic) BOOL right;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.right = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self reverseTapped:nil];
}

#pragma mark - animations

/**
 *  Animates the view from it's current position to the new position.
 */
- (void)animateInDirection:(BOOL) right{
    UIViewAnimationOptions opts = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear | UIViewAnimationOptionOverrideInheritedDuration;
    CGRect frame = self.animatedView.frame;
    frame.origin.x = [self destinationXCoordinateInDirection:right];
    [UIView animateWithDuration:1.0 delay:0.0 options:opts animations:^{
        self.animatedView.frame = frame;
    } completion:^(BOOL finished) {
        if(finished){
            //this space intentionally left blank
        }
    }];
}

/**
 *  Causes any current animations on puckImage to stop, keeping the puck in the same visible location.
 *  /return the stopping location of the puck
 */
-(void)cancelAnimations{
    self.animatedView.center = [((CALayer*)self.animatedView.layer.presentationLayer) position];
    [self.animatedView.layer removeAllAnimations];
    
}

- (IBAction)reverseTapped:(id)sender{
    [self cancelAnimations];
    [self animateInDirection:!self.right];
    self.right = !self.right;
//        self.label.text = self.right ? @"right" : @"left";
//    [UIView performWithoutAnimation:^{
//        self.containedLabel.text = self.right ? @"right" : @"left";
//    }];
}



-(CGFloat)destinationXCoordinateInDirection: (BOOL) right{
    if(right){
        return CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(self.animatedView.frame);
    }
    return 0.0;
}

@end
