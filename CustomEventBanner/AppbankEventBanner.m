//
//  AppbankEventBanner.m
//  AdmobMedi
//
//  Created by fizzco  on 12/08/14.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import "AppbankEventBanner.h"

@interface AppbankEventBanner (){}
@property (nonatomic,retain) NADView * appbankView;
@end
@implementation AppbankEventBanner

#pragma mark - requestBannerAd
-(void)requestBannerAd:(GADAdSize)adSize
             parameter:(NSString *)serverParameter
                 label:(NSString *)serverLabel
               request:(GADCustomEventRequest *)request {
    
    // 例えば@"APIKey,SpotID"の形式でParameter指定した場合
    NSArray * idArray = [serverParameter componentsSeparatedByString:@","];
    NSLog(@"AppBank Network IDs count:%d", idArray.count);
    
    if(idArray.count != 2){
        // 失敗扱いにしておく
        [self.delegate customEventBanner:self didFailAd:nil];
    }
    
    // AppBank Network
    NSLog(@"++ Appbank request banner ad");
    if(!self.appbankView){
        self.appbankView = [[NADView alloc]initWithFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
    }
//    [self.appbankView setIsOutputLog:YES];
    [self.appbankView setDelegate:self];
    [self.appbankView setNendID:idArray[0] spotID:idArray[1]];
    [self.appbankView load];
}

#pragma mark - NADView delegate
- (void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidFinishLoad");
}
#pragma mark - Success
- (void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidReceiveAd");
    
    // 広告受信成功をmediationへ通知
    [adView pause];
    [self.delegate customEventBanner:self didReceiveAd:adView];
}
#pragma mark - Error
- (void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidFailToReceiveAd");

    // 広告取得失敗をmediationへ通知
    [adView pause];
    [self.delegate customEventBanner:self didFailAd:adView.error];
}
#pragma mark - Click
-(void)nadViewDidClickAd:(NADView *)adView {
    NSLog(@"AppbankEventBanner nadViewDidClickAd");
    
    // Clickを通知
    [self.delegate customEventBanner:self clickDidOccurInAd:adView];
}

#pragma mark - CustomEventBanner life cycle
-(void)dealloc {
    NSLog(@"-- AppbankEventBanner dealloc");
    
    [self.appbankView setDelegate:nil];
    [self setAppbankView:nil];
    [self setDelegate:nil];
}

@end