//
//  nendEventBanner.m
//  AdmobMedi
//
//  Created by fizzco  on 12/08/14.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import "NendEventBanner.h"
#import "CustomEventConst.h"

@interface NendEventBanner(){
    NADView *nendView_;
}
@end
@implementation NendEventBanner
@synthesize delegate = delegate_;

#pragma mark -
#pragma requestBannerAd
-(void)requestBannerAd:(GADAdSize)adSize
             parameter:(NSString *)serverParameter
                 label:(NSString *)serverLabel
               request:(GADCustomEventRequest *)request {

    // nend
    NSLog(@"++ nendEventBanner request banner ad");
    if(!nendView_){
        nendView_ = [[NADView alloc]initWithFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];   
    }
    [nendView_ setDelegate:self];
    [nendView_ setNendID:NEND_API_KEY spotID:NEND_SPOT_ID];
    // nilでも構わないが、NSLogで警告が出るので空のインスタンスを渡す
    [nendView_ setRootViewController:([[UIViewController alloc]init])];
    // リクエストを開始
    [nendView_ load];
}

#pragma mark -
#pragma mark NADView delegate
- (void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"nendEventBanner nadViewDidFinishLoad");
}

#pragma mark - Success
- (void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"nendEventBanner nadViewDidReceiveAd start");

    NSLog(@"adView pause");
    [adView pause];
    [self.delegate customEventBanner:self didReceiveAd:adView];
//    //switch test
//    [adView pause];
//    [self.delegate customEventBanner:self didFailAd:nil];
}

#pragma mark - Error
- (void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"nendEventBanner nadViewDidFailToReceiveAd");

    // 無駄なリクエストを発行しないように止めておく
    [adView pause];
    NSLog(@"adView pause");

    // mediationへ受信失敗を通知
    [self.delegate customEventBanner:self didFailAd:nil];

    //didFailAd:で渡すNSErrorは任意なので、対応していない広告の場合はnilでok
}

#pragma mark -
#pragma mark life cycle
-(void)dealloc {
    NSLog(@"-- nendEventBanner dealloc");
    [nendView_ pause];
    nendView_.delegate = nil;
    nendView_ = nil;
    self.delegate =nil;
}
@end
