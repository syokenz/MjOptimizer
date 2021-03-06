//
//  TemplateMatcher.mm
//  MjOptimizer
//
//  Created by gino on 2014/06/20.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

#import "TemplateMatcher.h"
#import "MatcherResult.h"

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@implementation TemplateMatcher : NSObject

- (id)init {
    if (self == [super init]) {
    }
    return self;
}

-(NSMutableArray *)match:(UIImage *)target template:(UIImage *)tpl matchType:(int)matchType matchThre:(double)matchThre{
    cv::Mat targetMat;
    UIImageToMat(target, targetMat);
    
    cv::Mat tplMat;
    UIImageToMat(tpl, tplMat);
    
    //画像の変換
    if(matchType >= 1){
        //gray scaleにする
        cv::cvtColor(targetMat,targetMat,CV_RGB2GRAY);
        cv::cvtColor(tplMat,tplMat,CV_RGB2GRAY);
        if(matchType >= 2){
            //二値にする
            cv::adaptiveThreshold(targetMat, targetMat, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 5, 5);
            cv::adaptiveThreshold(tplMat, tplMat, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 5, 5);
        }
    }
    
    NSMutableArray *results = [NSMutableArray array];
    cv::Mat resultMat;
    double maxVal = 1.0;
    double prevVal = 1.0;
    do {
        cv::matchTemplate(targetMat, tplMat, resultMat, CV_TM_CCOEFF_NORMED);
        
        prevVal = maxVal;
        cv::Point maxPt;
        cv::minMaxLoc(resultMat, NULL, &maxVal, NULL, &maxPt);

        if (maxVal > matchThre) {
            MatcherResult *res = [[MatcherResult alloc]init];
            res.x = maxPt.x;
            res.y = maxPt.y;
            res.width = tplMat.cols;
            res.height = tplMat.rows;
            res.value = maxVal;
            [results addObject: res];
            
            cv::rectangle(targetMat, cv::Point(res.x, res.y),
                          cv::Point(res.x + res.width, res.y + res.height),
                          cv::Scalar(255,255,255));
            
        }
    } while (maxVal > matchThre && prevVal - maxVal > 0);
    
    return results;
}
@end