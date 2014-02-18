//
//  HelloWorldScene.m
//  KittyGeorge
//
//  Created by Ben Van Citters on 2/16/14.
//  Copyright Ben Van Citters 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "NewtonScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_sprite;
    CCSprite *_sprite2;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

-(void)initAudio
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    [audioSession requestRecordPermission:^(BOOL granted) {
        if(granted)
        {
            
            NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
            
            NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                      [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                      [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                      [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                      nil];
            
            NSError *error;
            
            recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
            
            if (recorder) {
                [recorder prepareToRecord];
                recorder.meteringEnabled = YES;
                [recorder record];
                levelTimer = [NSTimer scheduledTimerWithTimeInterval: 1/200.f target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
            } else
                NSLog([error description]);
        }
    }];


}
- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    float rotationAmount = 1-[recorder peakPowerForChannel:0]/-160.f;
    rotationAmount *= rotationAmount*rotationAmount;
    rotationAmount *= rotationAmount*rotationAmount;
    rotationAmount *= 60.f;
    [_sprite2 setRotation:rotationAmount];
	NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
}
- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    [self initAudio];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Add a sprite
    _sprite = [CCSprite spriteWithImageNamed:@"gwBody.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    _sprite2 = [CCSprite spriteWithImageNamed:@"gwHead.png"];
    _sprite2.position  = ccp(604.f,
                             453.f);
    [self addChild:_sprite2];

    
    // Animate sprite with action
    CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:60];
    //[_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    CCActionRotateBy* actionSpin2 = [CCActionRotateBy actionWithDuration:1.5f angle:60];
    [_sprite2 setAnchorPoint:CGPointMake(554.f/_sprite2.boundingBox.size.width,
                                         623.f/_sprite2.boundingBox.size.height)];
//    [_sprite2 runAction:[CCActionRepeatForever actionWithAction:actionSpin2]];
    [_sprite2 runAction:actionSpin2];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Pr frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
//    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
//    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
//    [_sprite runAction:actionMove];

}


-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLoc = [touch locationInNode:self];
//    CCActionRotateBy* actionSpin2 = [CCActionRotateBy actionWithDuration:0.01f angle:touchLoc.y];
//    //    [_sprite2 runAction:[CCActionRepeatForever actionWithAction:actionSpin2]];
//    [_sprite2 runAction:actionSpin2];
    [_sprite2 setRotation:touchLoc.y];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[NewtonScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end