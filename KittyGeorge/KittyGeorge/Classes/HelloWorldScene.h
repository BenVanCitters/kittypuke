//
//  HelloWorldScene.h
//  KittyGeorge
//
//  Created by Ben Van Citters on 2/16/14.
//  Copyright Ben Van Citters 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene
{
    AVAudioRecorder* recorder;
    NSTimer* levelTimer;
}
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end