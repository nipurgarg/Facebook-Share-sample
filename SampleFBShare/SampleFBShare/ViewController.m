//
//  ViewController.m
//  SampleFBShare
//
//  Created by Nipur on 14/06/16.
//  Copyright © 2016 VGroup. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

#define kShareURL @"http://dev.tournamentedition.com/event/hhhd"
#define kShareTitle @"some text"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    selectedMode= 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- share via SLComposeView

-(IBAction)ShareViaSLComposeView:(id)sender{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPost = [SLComposeViewController
                                           composeViewControllerForServiceType: SLServiceTypeFacebook];

        [fbPost setInitialText:kShareTitle];
        [fbPost addImage:[UIImage imageNamed:@"shareImage"]];
        [fbPost addURL: [NSURL URLWithString:kShareURL]];
        
        [self presentViewController:fbPost
                           animated:YES completion:nil];
        
        [fbPost setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        NSLog(@"Post Canceled");
                        break;
                    case SLComposeViewControllerResultDone:
                        NSLog(@"Post Sucessful");
                        
                        break;
                    default:
                        break;
                }
            }];
        }];
    }
    else{
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"No Facebook Accounts"
                                      message:@"There are no Facebook accounts configured. Please configure in settings."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark -- share via FBSDKShareDialog

-(IBAction)ShareViaFBSDKShareDialog:(id)sender{
  
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Mode Type"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"FBSDKShareDialogModeShareSheet",@"FBSDKShareDialogModeFeedBrowser",@"FBSDKShareDialogModeFeedWeb", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        selectedMode = 0;
        [self showFBSDKShareDialog];
    }
    else if (buttonIndex == 1){
        selectedMode = 1;
        [self showFBSDKShareDialog];
    }
    else if (buttonIndex == 2){
        selectedMode = 2;
        [self showFBSDKShareDialog];
    }
}

- (FBSDKShareLinkContent *)getShareLinkContent
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    content.contentTitle = kShareTitle;
    content.contentURL =  [NSURL URLWithString:kShareURL];
    content.imageURL = [NSURL URLWithString:@"https://s3.amazonaws.com/vgroup-tournament/te_event"];

    return content;
}

- (void)showFBSDKShareDialog{
    
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
    shareDialog.shareContent = [self getShareLinkContent];
    
    if(selectedMode == 0){
        shareDialog.mode = FBSDKShareDialogModeShareSheet;
    }
    else if (selectedMode == 1){
        shareDialog.mode = FBSDKShareDialogModeFeedBrowser;
    }
    else if (selectedMode == 2){
        shareDialog.mode = FBSDKShareDialogModeFeedWeb;
    }
    
    shareDialog.fromViewController = self;
    [shareDialog show];
}

@end
