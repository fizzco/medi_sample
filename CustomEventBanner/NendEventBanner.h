//
//  nendEventBanner.h
//  AdmobMedi
//
//  Created by fizzco  on 12/08/14.
//  Copyright (c) 2012年 fizzco . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADCustomEventBanner.h"
#import "NADView.h"

@interface NendEventBanner : NSObject <NADViewDelegate, GADCustomEventBanner>
@property (nonatomic,assign)id <GADCustomEventBannerDelegate> delegate;
@end
