//
//  ViewController.h
//  SampleFBShare
//
//  Created by Nipur on 14/06/16.
//  Copyright © 2016 VGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>{
    NSInteger selectedMode;
}


-(IBAction)ShareViaSLComposeView:(id)sender;

-(IBAction)ShareViaFBSDKShareDialog:(id)sender;


@end

