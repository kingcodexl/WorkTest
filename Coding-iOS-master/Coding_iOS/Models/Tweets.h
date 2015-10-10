//
//  Tweets.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-30.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import "User.h"
#import "HtmlMedia.h"
#import "Tweet.h"

@class TweetImage, Tweet,TweetSendLocationResponse;


typedef NS_ENUM(NSInteger, TweetType)
{
    TweetTypePublicTime = 0,
    TweetTypeUserFriends,
    TweetTypePublicHot,
    TweetTypeUserSingle
};


@interface Tweets : NSObject
@property (readwrite, nonatomic, strong) NSNumber *last_id;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;
@property (assign, nonatomic) TweetType tweetType;
@property (readwrite, nonatomic, strong) NSMutableArray *list;
@property (readwrite, nonatomic, strong) User *curUser;
@property (readwrite, nonatomic, strong) Tweet *nextTweet;

+ (Tweets *)tweetsWithType:(TweetType)tweetType;
+ (Tweets *)tweetsWithUser:(User *)curUser;
- (NSString *)localResponsePath;
- (void)configWithTweets:(NSArray *)responseA;

- (NSString *)toPath;
- (NSDictionary *)toParams;

@end



