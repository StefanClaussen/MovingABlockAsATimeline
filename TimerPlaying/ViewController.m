//
//  ViewController.m
//  TimerPlaying
//
//  Created by Stefan Claussen on 22/09/2014.
//  Copyright (c) 2014 One foot after the other. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UILabel *progress;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
}

@property (strong, nonatomic)UIView *timerBlockView;
@property (strong, nonatomic) IBOutlet UIButton *pauseAndPlayButtonLabel;
@property (nonatomic)BOOL isCountingDown;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    progress=[[UILabel alloc] initWithFrame:CGRectMake(80, 15, 100, 50)];
    progress.textColor=[UIColor redColor];
    [progress setText:@"Time : 25:00"];
    progress.backgroundColor=[UIColor clearColor];
    [self.view addSubview:progress];
    currMinute=25;
    currSeconds=00;
    
    [self setButtonToPlay];
    
    self.timerBlockView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [self.timerBlockView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.timerBlockView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)start
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveTimerBlock) userInfo:nil repeats:YES];
    
    [self moveTimerBlock];
}

- (void)stopTimer
{
    if(timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute -= 1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds -= 1;
            [self moveTimerBlock];
        }
        if(currMinute > -1)
            [progress setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
    }
    else
    {
        [timer invalidate];
    }
}

#pragma mark - Starting and pausing the timer

- (void)setButtonToPlay
{
    [self.pauseAndPlayButtonLabel setTitle:@"Play" forState:UIControlStateNormal];
}

- (void)setButtonToPause
{
    [self.pauseAndPlayButtonLabel setTitle:@"Pause" forState:UIControlStateHighlighted];
}

- (IBAction)playButtonPressed:(UIButton *)sender
{
    [self start];
    self.isCountingDown = YES;
    [self.pauseAndPlayButtonLabel setTitle:@"Pause" forState:UIControlStateNormal];
}

- (IBAction)stopButtonPressed:(UIButton *)sender
{
    [self stopTimer];
}


- (IBAction)pauseButtonPressed:(UIButton *)sender
{
    
}


#pragma mark - Moving Timer Block helper methods

- (void)moveTimerBlock
{
    CGRect timerBlockFrame = self.timerBlockView.frame;
    timerBlockFrame.origin.x = 40;    //Finish point of block
    
        [UIView animateWithDuration:10.0
                     animations:^{
                         self.timerBlockView.frame = timerBlockFrame;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
