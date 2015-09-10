//
//  ViewController.m
//  PlayYoukuVideo
//
//  Created by yumlive0909 on 15/9/10.
//  Copyright (c) 2015年 yumlive0909. All rights reserved.
//

#import "ViewController.h"


#define VideoThumbnailWidth  [UIScreen mainScreen].bounds.size.width - 20
#define VideoThumbnailHeight [UIScreen mainScreen].bounds.size.height / 2 - 20


@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,copy)NSString *jsString;
@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setWebviewAttribute];
    
    NSString *videoURL = @"http://v.youku.com/v_show/id_XNDcwMDc3MTk2.html?from=y1.7-2";
    
    NSString *encodedURL=[videoURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *youkuId = [self getYoukuVideoIdByUrl:encodedURL];
    
    
    NSString *js = @"<div id=\"youkuplayer\" style=\"width:%fpx;height:%fpx\"></div> <script type=\"text/javascript\" src=\"http://player.youku.com/jsapi\"> player = new YKU.Player('youkuplayer',{ styleid: '0', client_id: 'b1b8d127374e42ee', vid: '%@',autoplay: true}); </script>";
    
    
    self.jsString = [NSString stringWithFormat:js,VideoThumbnailWidth,VideoThumbnailHeight,youkuId];
    
    //[self.videoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedURL]]];
    
    [self.videoWebView loadHTMLString:self.jsString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setVideoWebView:nil];
    [self.videoWebView loadHTMLString:@"" baseURL: nil];
}

- (void)setWebviewAttribute
{
    self.videoWebView.delegate = self;
    self.videoWebView.opaque = NO; //不设置这个值 页面背景始终是白色
    self.videoWebView.backgroundColor = [UIColor clearColor];
    [self.videoWebView setScalesPageToFit:NO];
}

/** 截取出优酷视频的id*/
-(NSString *)getYoukuVideoIdByUrl:(NSString *)videourl
{
    if (videourl != nil && ![videourl isEqualToString:@""]) {
        NSString *youkuId;
        NSArray *firSep = [videourl componentsSeparatedByString:@"id_"];
        if ([firSep count] > 0 && firSep != nil)
        {
            NSArray *secSep = [[firSep lastObject] componentsSeparatedByString:@"."];
            if ([secSep count] >0 && secSep != nil)
            {
                youkuId = [secSep firstObject];
            }
        }
        return youkuId;
        
    } else {
        return @"";
    }
}


-(void)webViewDidStartLoad:(UIWebView *)webView{}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#0E0E0E'"];
}


-(BOOL)shouldAutorotate
{
    return YES;
}
//支持的方向
- (NSUInteger)supportedInterfaceOrientations
{
    NSInteger mask;
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            mask = UIInterfaceOrientationMaskLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            mask = UIInterfaceOrientationMaskLandscapeRight;
            break;
        case UIInterfaceOrientationPortrait:
            mask = UIInterfaceOrientationMaskPortrait;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            mask = UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        default:
            mask = UIInterfaceOrientationPortrait;
            break;
    }
    return mask;
    
}

@end


