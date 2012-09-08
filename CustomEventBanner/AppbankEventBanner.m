//
//  AppbankEventBanner.m
//  AdmobMedi
//
//  Created by fizzco  on 12/08/14.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import "AppbankEventBanner.h"
#import "CustomEventConst.h"

@interface AppbankEventBanner (){
    NADView *appbankView_;
    UIViewController * viewController_;
}
@end
@implementation AppbankEventBanner
@synthesize delegate = delegate_;


#pragma mark -
#pragma requestBannerAd
-(void)requestBannerAd:(GADAdSize)adSize
             parameter:(NSString *)serverParameter
                 label:(NSString *)serverLabel
               request:(GADCustomEventRequest *)request {
    
    // AppBank
    NSLog(@"++ Appbank request banner ad");
    if(!appbankView_){
        appbankView_ = [[NADView alloc]initWithFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
    }
    [appbankView_ setDelegate:self];
    [appbankView_ setNendID:APPBANK_API_KEY spotID:APPBANK_SPOT_ID];
    [appbankView_ setRootViewController:([[UIViewController alloc]init])];
    [appbankView_ load];
}

#pragma mark -
#pragma mark NADView delegate
- (void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidFinishLoad");
}

#pragma mark - Success
- (void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidReceiveAd");
    
    [adView pause];
    NSLog(@"adView pause");
    
    // 広告受信成功をmediationへ通知
    [self.delegate customEventBanner:self didReceiveAd:adView];
}
#pragma mark - Error
- (void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidFailToReceiveAd");

    [adView pause];
    NSLog(@"adView pause");
    
    // 広告取得失敗をmediationへ通知
    [self.delegate customEventBanner:self didFailAd:nil];
}

#pragma mark -
#pragma mark life cycle
-(void)dealloc {
    NSLog(@"-- AppbankEventBanner dealloc");
    [appbankView_ pause];
    appbankView_.delegate = nil;
    appbankView_ = nil;
    self.delegate =nil;
}


@end