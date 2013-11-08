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

    // 320*50のバナー広告としてGADBannerViewインスタンスを生成する例
    bannerView_ = [[GADBannerView alloc]initWithAdSize:kGADAdSizeBanner];
    [bannerView_ setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];

    // AdMobの広告ユニットIDを設定
    [bannerView_ setAdUnitID:@"Set Your AdUnitID !"];
    [bannerView_ setRootViewController:self];
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
     [bannerView_ setRootViewController:nil];
     [bannerView_ setDelegate:nil];
     bannerView_ = nil;

 }

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // １．画面上部
//    [bannerView_ setFrame:CGRectMake((self.view.frame.size.width - bannerView_.frame.size.width) /2, 0, bannerView_.frame.size.width, bannerView_.frame.size.height)];
    // ２．画面下部
    [bannerView_ setFrame:CGRectMake((self.view.frame.size.width - bannerView_.frame.size.width) /2, self.view.frame.size.height - bannerView_.frame.size.height, bannerView_.frame.size.width, bannerView_.frame.size.height)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
