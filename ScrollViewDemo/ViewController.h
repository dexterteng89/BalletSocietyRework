//
//  ViewController.h
//  ScrollViewDemo
//
//  Created by Ross Matsuda on 9/8/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    //These are our two views, the image view and the scroll view that houses it
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *bottomFrame;
@property (strong, nonatomic) IBOutlet UIView *topFrame;

//Text fields
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) IBOutlet UITextView *creditsText;
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *captionText;
@property (strong, nonatomic) IBOutlet UILabel *questionText;
//View that holds the question and the black overlay
@property (strong, nonatomic) IBOutlet UIView *questionOverlay;

//Strings for differentiating question from description
@property (strong, nonatomic) NSString * questionString;
@property (strong, nonatomic) NSString * descriptionString;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *questionButton;
- (IBAction)questionButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)dismissQuestionPressed:(id)sender;
- (IBAction)bottomFrameDismiss:(id)sender;
- (IBAction)topFrameDismiss:(id)sender;

//Incrementor for testing
- (IBAction)nextButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIImageView *nextButtonTransitionBlack;

//Which content to load
@property (strong, nonatomic) NSString *contentToLoadString;

//Code to fix weird centering behavior
- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint;

@end
