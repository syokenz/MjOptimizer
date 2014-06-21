//
//  TemplateMatcher.mm
//  MjOptimizer
//
//  Created by gino on 2014/06/20.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TemplateMatcher.h"
#import "MatcherResult.h"

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@implementation TemplateMatcher : NSObject

NSMutableDictionary *templates;

+(UIImage *)DetectEdgeWithImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_BGR2GRAY);
    
    cv::Mat edge;
    cv::Canny(gray, edge, 200, 180);
    
    cv::Mat hoge = loadMatFromFile(@"j1.r", @"jpg");
    
    TemplateMatcher *matcher = [[TemplateMatcher alloc] init];
    [matcher matchTarget:image withTemplate:@"s6t"];
    
    UIImage *edgeImg = MatToUIImage(hoge);
    //UIImage *edgeImg = MatToUIImage(edge);
    
    return edgeImg;
}

-(NSMutableArray *)match:(UIImage *)target template:(UIImage *)tpl {
    cv::Mat targetMat;
    UIImageToMat(target, targetMat);
    
    cv::Mat tplMat;
    UIImageToMat(tpl, tplMat);

    NSMutableArray *results = [NSMutableArray array];
    cv::Mat resultMat;
    double maxVal = 1.0;
    double prevVal = 1.0;
    do {
        cv::matchTemplate(targetMat, tplMat, resultMat, CV_TM_CCOEFF_NORMED);
        
        prevVal = maxVal;
        cv::Point maxPt;
        cv::minMaxLoc(resultMat, NULL, &maxVal, NULL, &maxPt);

        if (maxVal > 0.6) {
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
    } while (maxVal > 0.6 && prevVal - maxVal > 0);
    
    return results;
}

static cv::Mat loadMatFromFile(NSString *fileBaseName, NSString *type) {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileBaseName ofType:type];
    const char *pathChars = [path UTF8String];
    return cv::imread(pathChars);
}


- (id)init {
    if (self == [super init]) {
        [self setUpTemplate];
    }
    return self;
}

- (void)setUpTemplate {
    templates = [NSMutableDictionary dictionary];
    [templates setObject: [self loadTemplateImage:@"m1.t"] forKey:@"m1t"];
    [templates setObject: [self loadTemplateImage:@"m2.t"] forKey:@"m2t"];
    [templates setObject: [self loadTemplateImage:@"m3.t"] forKey:@"m3t"];
    [templates setObject: [self loadTemplateImage:@"m4.t"] forKey:@"m4t"];
    [templates setObject: [self loadTemplateImage:@"m5.t"] forKey:@"m5t"];
    [templates setObject: [self loadTemplateImage:@"m6.t"] forKey:@"m6t"];
    [templates setObject: [self loadTemplateImage:@"m7.t"] forKey:@"m7t"];
    [templates setObject: [self loadTemplateImage:@"m8.t"] forKey:@"m8t"];
    [templates setObject: [self loadTemplateImage:@"m9.t"] forKey:@"m9t"];
    [templates setObject: [self loadTemplateImage:@"p1.t"] forKey:@"p1t"];
    [templates setObject: [self loadTemplateImage:@"p2.t"] forKey:@"p2t"];
    [templates setObject: [self loadTemplateImage:@"p3.t"] forKey:@"p3t"];
    [templates setObject: [self loadTemplateImage:@"p4.t"] forKey:@"p4t"];
    [templates setObject: [self loadTemplateImage:@"p5.t"] forKey:@"p5t"];
    [templates setObject: [self loadTemplateImage:@"p6.t"] forKey:@"p6t"];
    [templates setObject: [self loadTemplateImage:@"p7.t"] forKey:@"p7t"];
    [templates setObject: [self loadTemplateImage:@"p8.t"] forKey:@"p8t"];
    [templates setObject: [self loadTemplateImage:@"p9.t"] forKey:@"p9t"];
    [templates setObject: [self loadTemplateImage:@"s1.t"] forKey:@"s1t"];
    [templates setObject: [self loadTemplateImage:@"s2.t"] forKey:@"s2t"];
    [templates setObject: [self loadTemplateImage:@"s3.t"] forKey:@"s3t"];
    [templates setObject: [self loadTemplateImage:@"s4.t"] forKey:@"s4t"];
    [templates setObject: [self loadTemplateImage:@"s5.t"] forKey:@"s5t"];
    [templates setObject: [self loadTemplateImage:@"s6.t"] forKey:@"s6t"];
    [templates setObject: [self loadTemplateImage:@"s7.t"] forKey:@"s7t"];
    [templates setObject: [self loadTemplateImage:@"s8.t"] forKey:@"s8t"];
    [templates setObject: [self loadTemplateImage:@"s9.t"] forKey:@"s9t"];
    [templates setObject: [self loadTemplateImage:@"j1.t"] forKey:@"j1t"];
    [templates setObject: [self loadTemplateImage:@"j2.t"] forKey:@"j2t"];
    [templates setObject: [self loadTemplateImage:@"j3.t"] forKey:@"j3t"];
    [templates setObject: [self loadTemplateImage:@"j4.t"] forKey:@"j4t"];
    [templates setObject: [self loadTemplateImage:@"j5.t"] forKey:@"j5t"];
    [templates setObject: [self loadTemplateImage:@"j6.t"] forKey:@"j6t"];
    [templates setObject: [self loadTemplateImage:@"j7.t"] forKey:@"j7t"];
}

-(UIImage *)loadTemplateImage:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}


-(NSMutableArray *)matchTarget:(UIImage *)target withTemplate:(NSString *)key {
    UIImage *tpl = (UIImage *)[templates objectForKey:key];
    return [self match:target template:tpl];
}

@end