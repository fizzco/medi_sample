//
//  ViewController.m
//  medi
//
//  Created by fizzco on 12/09/08.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import "ViewController.h"

GADBannerView * bannerView_;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ----- admob mediation -----

    // 320*50のバナー広告としてGADBannerViewインスタンスを生成
    bannerView_ = [[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner];

    // admob PublisherIDでなくmediationIDを設定
    bannerView_.adUnitID = @"YourMediationID";
    bannerView_.rootViewController = self;
    [bannerView_ setDelegate:self];
    [self.view addSubview:bannerView_];

    // リクエスト開始
    [bannerView_ loadRequest:[GADRequest request]];

    // ----- admob mediation -----

}
 #pragma mark
 - (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
     NSLog(@"adViewDidReceiveAd");
 }
 - (void)adView:(GADBannerView *)bannerView
 didFailToReceiveAdWithError:(GADRequestError *)error{
     NSLog(@"didFailToReceiveAdWithError");
 }

 #pragma mark
 -(void)dealloc {
     NSLog(@"dealloc");
     bannerView_.rootViewController = nil;
     bannerView_.delegate = nil;
     bannerView_ = nil;

 }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
