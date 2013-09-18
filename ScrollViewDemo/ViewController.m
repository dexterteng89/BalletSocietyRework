//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by Ross Matsuda on 9/8/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//  Tutorial used: http://agilewarrior.wordpress.com/2012/05/18/uiscrollview-examples/
//
//  Created an imageview the size of the screen, added a picture.
//  Set picture to "top left" for starting orientation.
//  Editor menu, embed in, scroll view
//  Then set the scroll view content size below
//  Set background color of root view to dark gray, do not need to change background
//  color of other views.

//Second tutorial on zooming: http://iosdeveloperzone.com/2012/07/07/tutorial-all-about-images-part-2-panning-zooming-with-uiscrollview/
//Please note that for now, confining this project to Landscape, will later add portrait orientation.
//It will rotate according to how it's held, so both landscape orientations are supported.


#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize scrollView, imageView, topFrame, bottomFrame, infoButton, questionButton, descriptionText, titleText, creditsText, captionText, contentToLoadString, questionString, descriptionString, questionOverlay, questionText, nextButton, nextButtonTransitionBlack;
- (void)viewDidLoad
{
    [super viewDidLoad];

    //To find fonts
    //1: HelveticaNeue-UltraLight
    //2: HelveticaNeue-Light
    
    //First, detect what content was passed from the segue
    // take the variable contentToLoadString, pull the two-digit number out of it, and use that to find the
    // support text files. So, if the string passed was "01", it'll generate the names for 01-description,
    // 01-caption, 01-question, and the rest.
    //
    //Right now, 01-01 through 01-12 are working
    contentToLoadString = @"01-01";
    
    //Temporary call for the next button transition to start transparent
    nextButtonTransitionBlack.alpha = 0;
    
    //Method (described below) that loads jpg and text resources for the current view, then resets the frame sizes
    [self loadAllDataForImage:contentToLoadString];
    [self resetViewFrames];
        
    //Behold, a single tap gesture recognizer
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [scrollView addGestureRecognizer:singleTap];
    
    //Behold, a double tap gesture recognizer
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [scrollView addGestureRecognizer:doubleTap];
    
    //To help the app differentiate single from double taps
    [singleTap requireGestureRecognizerToFail : doubleTap];
    [doubleTap setDelaysTouchesBegan : YES];
    [singleTap setDelaysTouchesBegan : YES];
    
}

//Method to populate images and text fields
- (void) loadAllDataForImage:(NSString *)imageNumber
{
    //Load appropriate picture
    NSString * imageResourcePath = [NSString stringWithFormat:@"%@.jpg", imageNumber];
    imageView.image = [UIImage imageNamed:imageResourcePath];
    
    //Assign title
    NSString * titleResourcePath = [NSString stringWithFormat:@"%@-title", imageNumber];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:titleResourcePath ofType:@"txt"];
    NSString *textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    titleText.text = textFromFile;
    titleText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    
    //Assign caption
    NSString * captionResourcePath = [NSString stringWithFormat:@"%@-caption", imageNumber];
    filePath = [[NSBundle mainBundle] pathForResource:captionResourcePath ofType:@"txt"];
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    captionText.text = textFromFile;
    captionText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    
    //Caption alignment procedure
    captionText.numberOfLines = 0;
    [captionText sizeToFit];
    CGRect myFrame = captionText.frame;
    // Resize the frame's width to 280 (320 - margins)
    // width could also be myOriginalLabelFrame.size.width
    myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y, 708, myFrame.size.height);
    captionText.frame = myFrame;
    
    //Assign credits
    NSString * creditsResourcePath = [NSString stringWithFormat:@"%@-credits", imageNumber];
    filePath = [[NSBundle mainBundle] pathForResource:creditsResourcePath ofType:@"txt"];
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    creditsText.text = textFromFile;
    creditsText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    
    //Create strings for question and description
    NSString * questionResourcePath = [NSString stringWithFormat:@"%@-question", imageNumber];
    filePath = [[NSBundle mainBundle] pathForResource:questionResourcePath ofType:@"txt"];
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    questionString = textFromFile;
    questionText.text = questionString;
    questionText.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
    
    NSString * descriptionResourcePath = [NSString stringWithFormat:@"%@-description", imageNumber];
    filePath = [[NSBundle mainBundle] pathForResource:descriptionResourcePath ofType:@"txt"];
    textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    descriptionString = textFromFile;
    descriptionText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
}

-(void) resetViewFrames
{
    //Set scrollview size to equal the size of the image content. This way you can drag and it'll snap back!
    scrollView.contentSize = self.imageView.image.size;
    [self.imageView sizeToFit];
    
    //Zoom enabling and limiters
    if (imageView.image.size.width > imageView.image.size.height)
    {
        self.scrollView.minimumZoomScale = self.scrollView.frame.size.width / imageView.image.size.width;
    }
    else
    {
        self.scrollView.minimumZoomScale = self.scrollView.frame.size.height / imageView.image.size.height;
    }
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //Setup for the frames - start them transparent
    topFrame.alpha = 0;
    bottomFrame.alpha = 0;
    
    //For the bottom frame, if origin.y = 310, it's in details view, or center.y 539
    //For the bottom frame, if origin.y = 550, it's in question view, or center.y 779
    //For the bottom frame, if origin.y = 662, no button has been pressed. The center, here, is 891, a difference of 229
    self.bottomFrame.center = CGPointMake(self.bottomFrame.center.x, 891);
    
    //Horrible workaround to get the damn text fields to actually appears
    CGRect frame = descriptionText.frame;
    frame.size.height += 1;
    descriptionText.frame = frame;
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale];
}

//Button methods
- (IBAction)questionButtonPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){
        questionOverlay.alpha = 1;
        //Set button state to "selected"
        [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];            }];
    
    //This is the code to load the question in the bottom frame, uncomment to turn it back on.
//    if (self.bottomFrame.center.y == 891)       //If frame is at lowest position
//    {
//        [UIView animateWithDuration:0.35 animations:^(void){
//            bottomFrame.center = CGPointMake(bottomFrame.center.x, 779);
//            //Add code here to change button image to other color
//        }];
//        //Set button state to "selected"
//        [questionButton setImage:[UIImage imageNamed:@"discuss_selected"] forState:UIControlStateNormal];
//        //Change text from description to question
//        descriptionText.text = questionString;
//        descriptionText.font = [UIFont systemFontOfSize:24];
//        return;
//    }
//
//    if (self.bottomFrame.center.y == 779)       //If frame is at the question position
//    {
//        [UIView animateWithDuration:0.35 animations:^(void){
//            bottomFrame.center = CGPointMake(bottomFrame.center.x, 891);
//            //Set button state to "deselected"
//            [questionButton setImage:[UIImage imageNamed:@"discuss"] forState:UIControlStateNormal];
//        }];
//        return;
//    }
//
//    if (self.bottomFrame.center.y == 539)       //If frame is at the details position
//    {
//        [UIView animateWithDuration:0.35 animations:^(void){
//            bottomFrame.center = CGPointMake(bottomFrame.center.x, 779);
//            //Set button state to "selected", deselect info button
//            [questionButton setImage:[UIImage imageNamed:@"discuss_selected"] forState:UIControlStateNormal];
//            [infoButton setImage:[UIImage imageNamed:@"moreinfo"] forState:UIControlStateNormal];
//
//        }];
//        //Change text from description to question
//        descriptionText.text = questionString;
//        descriptionText.font = [UIFont systemFontOfSize:24];
//        return;
//    }
}
- (IBAction)dismissQuestionPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){
        questionOverlay.alpha = 0;
        //Set button state to "selected"
        [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];            }];
    

}

- (IBAction)bottomFrameDismiss:(id)sender {
    //Same thing as if you tap the background
    if (topFrame.alpha == 0)
    {
        [UIView animateWithDuration:0.15 animations:
         ^(void)
         {
             topFrame.alpha = 1;
             bottomFrame.alpha = 1;
             nextButton.alpha = 0.2;
             [infoButton setImage:[UIImage imageNamed:@"moreinfo"] forState:UIControlStateNormal];
             [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];
         }];
        
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:
         ^(void)
         {
             topFrame.alpha = 0;
             bottomFrame.alpha = 0;
             nextButton.alpha = 1;
             bottomFrame.center = CGPointMake(bottomFrame.center.x, 891);
         }];
    }
}

- (IBAction)topFrameDismiss:(id)sender {
    //same thing as if you tap the background
    if (topFrame.alpha == 0)
    {
        [UIView animateWithDuration:0.15 animations:
         ^(void)
         {
             topFrame.alpha = 1;
             bottomFrame.alpha = 1;
             nextButton.alpha = 0.2;
             [infoButton setImage:[UIImage imageNamed:@"moreinfo"] forState:UIControlStateNormal];
             [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];
         }];
        
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:
         ^(void)
         {
             topFrame.alpha = 0;
             bottomFrame.alpha = 0;
             nextButton.alpha = 1;
             bottomFrame.center = CGPointMake(bottomFrame.center.x, 891);
         }];
    }
}

- (IBAction)infoButtonPressed:(id)sender {
        if (self.bottomFrame.center.y == 891)       //If frame is at lowest position
        {
            [UIView animateWithDuration:0.35 animations:^(void){
                bottomFrame.center = CGPointMake(bottomFrame.center.x, 539);
                //Set button state to "selected"
                [infoButton setImage:[UIImage imageNamed:@"moreinfo_selected"] forState:UIControlStateNormal];            }];
            self.creditsText.frame = self.creditsText.frame;
            //Change text from question to description
            descriptionText.text = descriptionString;

            return;
        }
    
    if (self.bottomFrame.center.y == 779)       //If frame is at the question position
    {
        [UIView animateWithDuration:0.35 animations:^(void){
            bottomFrame.center = CGPointMake(bottomFrame.center.x, 539);
            //Set button state to "selected", deselect question button
            [infoButton setImage:[UIImage imageNamed:@"moreinfo_selected"] forState:UIControlStateNormal];
            [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];

        }];
        self.creditsText.frame = self.creditsText.frame;
        
        //Change text from question to description
        descriptionText.text = descriptionString;


        return;
    }
    
    if (self.bottomFrame.center.y == 539)       //If frame is at the details position
    {
        [UIView animateWithDuration:0.35 animations:^(void){
            bottomFrame.center = CGPointMake(bottomFrame.center.x, 891);
            //Set button state to "deselected"
            [infoButton setImage:[UIImage imageNamed:@"moreinfo"] forState:UIControlStateNormal];
        }];
        return;
    }
}

- (IBAction)backButtonPressed:(id)sender {
    
    NSLog(@"back button pressed");
}

//Method for zooming
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//This method fires when a user is ABOUT to scroll
//We're going to have it when the user begins to move the UI, that the overlay disappears
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.35 animations:
     ^(void)
     {
         topFrame.alpha = 0;
         bottomFrame.alpha = 0;
     }];
    
}
//This method fires when a user is ABOUT to zoom
//We're going to have it when the user begins to zoom the UI, that the overlay disppaers
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    [UIView animateWithDuration:0.35 animations:
     ^(void)
     {
         topFrame.alpha = 0;
         bottomFrame.alpha = 0;
         nextButton.alpha = 1;
     }];
}

//Method for single tap behavior, show or hide the frames based on current alpha level
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (topFrame.alpha == 0)
    {
        [UIView animateWithDuration:0.15 animations:
         ^(void)
         {
             topFrame.alpha = 1;
             bottomFrame.alpha = 1;
             nextButton.alpha = 0.2;
             [infoButton setImage:[UIImage imageNamed:@"moreinfo"] forState:UIControlStateNormal];
             [questionButton setImage:[UIImage imageNamed:@"thinkerButton"] forState:UIControlStateNormal];
         }];

    }
    else
    {
        [UIView animateWithDuration:0.2 animations:
         ^(void)
         {
             topFrame.alpha = 0;
             bottomFrame.alpha = 0;
             nextButton.alpha = 1;
             bottomFrame.center = CGPointMake(bottomFrame.center.x, 891);
         }];
    }
}

//Method for double tap behavior, here, go to default zoom level
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms to lowest level possible
    [scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
}


//Methods to deal with odd centering behavior
- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint
{
    CGRect vf = view.frame;
    CGPoint co = self.scrollView.contentOffset;
    
    CGFloat x = centerPoint.x - vf.size.width / 2.0;
    CGFloat y = centerPoint.y - vf.size.height / 2.0;
    
    if(x < 0)
    {
        co.x = -x;
        vf.origin.x = 0.0;
    }
    else
    {
        vf.origin.x = x;
    }
    
    if(y < 0)
    {
        co.y = -y;
        vf.origin.y = 0.0;
    }
    else
    {
        vf.origin.y = y;
    }
    
    view.frame = vf;
    self.scrollView.contentOffset = co;
}

//This method fires when a user begins to scroll
- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
        zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
    }
    else
    {
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}

//WE'RE OVERRIDING VIEWDIDAPPEAR FOR SOME REASON, JESUS
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.scrollView.bounds),
                                      CGRectGetMidY(self.scrollView.bounds));
    [self view:self.imageView setCenter:centerPoint];
}

//Code for the next button (temporary)
- (IBAction)nextButtonPressed:(id)sender {
    //And make it sexy
    //nextButtonTransitionBlack.alpha=1;
    [UIView animateWithDuration:0.15 animations:^(void)
     { nextButtonTransitionBlack.alpha= 1;}
                     completion:^(BOOL finished)
                    {
                        //Get last two digits of contentToLoadString
                        NSString * imageValueString = [self.contentToLoadString substringFromIndex: [self.contentToLoadString length] - 2];
                        int imageValueStringAsInt = [imageValueString intValue];
                        
                        //Method to make sure the next button loops if it hits 12
                        if (imageValueStringAsInt == 12)
                        {
                            imageValueStringAsInt = 01;
                        }
                        else
                        {
                            imageValueStringAsInt ++;
                        }
                        //Add a "0" in front of the string if needed
                        if (imageValueStringAsInt < 10)
                        {
                            imageValueString = [NSString stringWithFormat: @"0%d", imageValueStringAsInt];
                        }
                        else
                        {
                            imageValueString = [NSString stringWithFormat: @"%d", imageValueStringAsInt];
                        }
                        //Set content choice to the next in the list
                        self.contentToLoadString = [NSString stringWithFormat: @"01-%@", imageValueString];
                        //Now let's reload EVERYTHING, DAMMIT!
                        [self loadAllDataForImage: contentToLoadString];
                        [self resetViewFrames];
                        nextButton.alpha = 1;

                         [UIView animateWithDuration:0.5 animations:
                          ^{nextButtonTransitionBlack.alpha = 0.1;}
                          ];
                     }
     ];
    
    
//    //Get last two digits of contentToLoadString
//    NSString * imageValueString = [self.contentToLoadString substringFromIndex: [self.contentToLoadString length] - 2];
//    int imageValueStringAsInt = [imageValueString intValue];
//    
//    //Method to make sure the next button loops if it hits 12
//    if (imageValueStringAsInt == 12)
//    {
//        imageValueStringAsInt = 01;
//    }
//    else
//    {
//    imageValueStringAsInt ++;
//    }
//    //Add a "0" in front of the string if needed
//    if (imageValueStringAsInt < 10)
//    {
//        imageValueString = [NSString stringWithFormat: @"0%d", imageValueStringAsInt];
//    }
//    else
//    {
//        imageValueString = [NSString stringWithFormat: @"%d", imageValueStringAsInt];
//    }
//        //Set content choice to the next in the list
//    self.contentToLoadString = [NSString stringWithFormat: @"01-%@", imageValueString];
//    //Now let's reload EVERYTHING, DAMMIT!
//    [self loadAllDataForImage: contentToLoadString];
//    [self resetViewFrames];
//    nextButton.alpha = 1;

}





//End of section for correcting zoom behavior
#pragma end of program
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
