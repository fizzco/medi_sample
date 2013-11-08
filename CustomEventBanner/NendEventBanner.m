//
//  nendEventBanner.m
//  AdmobMedi
//
//  Created by fizzco  on 12/08/14.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import "NendEventBanner.h"
#import "CustomEventConst.h"

@interface NendEventBanner(){}
@property (nonatomic,retain) NADView * nendView;
@end
@implementation NendEventBanner

#pragma mark - requestBannerAd
-(void)requestBannerAd:(GADAdSize)adSize
             parameter:(NSString *)serverParameter
                 label:(NSString *)serverLabel
               request:(GADCustomEventRequest *)request {
    
    // 例えば@"APIKey,SpotID"の形式でParameter指定した場合
    NSArray * idArray = [serverParameter componentsSeparatedByString:@","];
    NSLog(@"NendEventBanner parameter IDs count:%d", idArray.count);
    
    if(idArray.count != 2){
        // 失敗扱いにしておく
        [self.delegate customEventBanner:self didFailAd:nil];
    }
    
    // Nend
    NSLog(@"++ Nend request banner ad");
    if(!self.nendView){
        self.nendView = [[NADView alloc]initWithFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
    }
    //    [nendView setIsOutputLog:YES];
    [self.nendView setDelegate:self];
    [self.nendView setNendID:idArray[0] spotID:idArray[1]];
    [self.nendView load];
}

#pragma mark - NADView delegate
- (void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"NendEventBanner nadViewDidFinishLoad");
}
#pragma mark - Success
- (void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"NendEventBanner nadViewDidReceiveAd");
    
    // 広告受信成功をmediationへ通知
    [adView pause];
    [self.delegate customEventBanner:self didReceiveAd:adView];
}
#pragma mark - Error
- (void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"NendEventBanner nadViewDidFailToReceiveAd");
    
    // 広告取得失敗をmediationへ通知
    [adView pause];
    [self.delegate customEventBanner:self didFailAd:adView.error];
}
#pragma mark - Click
-(void)nadViewDidClickAd:(NADView *)adView {
    NSLog(@"NendEventBanner nadViewDidClickAd");
    
    // Clickを通知
    [self.delegate customEventBanner:self clickDidOccurInAd:adView];
}

#pragma mark - CustomEventBanner life cycle
-(void)dealloc {
    NSLog(@"-- NendEventBanner dealloc");
    
    [self.nendView setDelegate:nil];
    [self setNendView:nil];
    [self setDelegate:nil];
}

@end
