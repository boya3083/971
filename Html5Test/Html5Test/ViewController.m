//
//  ViewController.m
//  Html5Test
//
//  Created by apple on 14-12-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


-(bool)isShowBar{
    return KIsiPhoneX || iPhoneXS_Max || IS_IPHONE_Xr || IS_IPHONE_Xs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    //加载webview
    CGRect frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.opaque = NO;
    [self.view addSubview:_webView];
    
    //加载html内容
    NSString *infoSouceFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *infoText = [NSString stringWithContentsOfFile:infoSouceFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:infoText baseURL:[NSURL URLWithString:infoSouceFile]];
    
    UIImage* imageTop = [UIImage imageNamed:@"images/top.png"];
    
    
    NSLog(@"===frdeerror:%f",imageTop.size.width);
    NSLog(@"==self.view.bounds.size.width=%f",self.view.bounds.size.width);
    _imageViewTop=[[UIImageView alloc] init];
    [_imageViewTop setImage:imageTop];
 
    [self.view addSubview:_imageViewTop];
    
    UIImage* imageBottom = [UIImage imageNamed:@"images/bottom.png"];
    _imageViewDown=[[UIImageView alloc] init];
    [_imageViewDown setImage:imageBottom];

    [self.view addSubview:_imageViewDown];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [_imageViewTop setHidden:YES];
        [_imageViewDown setHidden:YES];
    }
    CGRect frameTop ;
    CGRect frameDown;
    //KIsiPhoneX || iPhoneXS_Max || IS_IPHONE_Xr || IS_IPHONE_Xs
    NSInteger pw = (self.view.bounds.size.width - self.view.bounds.size.width/imageTop.size.width * imageTop.size.width)/2;
    NSInteger w = self.view.bounds.size.width/imageTop.size.width * imageTop.size.width;
    
    if(iPhoneXS_Max || IS_IPHONE_Xr){
        frameTop = CGRectMake(pw , self.view.bounds.size.height/2 - imageTop.size.height -265 , w, imageTop.size.height);
        frameDown =  CGRectMake(pw , self.view.bounds.size.height/2 + 275, w, imageBottom.size.height);
    }else if(IS_IPHONE_Xs){
        frameTop = CGRectMake(pw, self.view.bounds.size.height/2 - imageTop.size.height -240 , w, imageTop.size.height);
        frameDown =  CGRectMake(pw, self.view.bounds.size.height/2 + 250, w, imageBottom.size.height);
    }else if (iPhone6plus){
        frameTop = CGRectMake(pw , self.view.bounds.size.height/2 - imageTop.size.height* 0.7 -270 , w, imageTop.size.height* 0.7);
        frameDown =  CGRectMake(pw , self.view.bounds.size.height/2 + 270, w, imageBottom.size.height * 0.7);
    }else if (iPhone6){
        frameTop = CGRectMake(pw, self.view.bounds.size.height/2 - imageTop.size.height* 0.65 -245 , w, imageTop.size.height* 0.65);
        frameDown =  CGRectMake(pw , self.view.bounds.size.height/2 + 245, w, imageBottom.size.height* 0.7);
    }else{
        frameTop = CGRectMake(pw , self.view.bounds.size.height/2 - imageTop.size.height* 0.55 -208 , w, imageTop.size.height* 0.55);
        frameDown =  CGRectMake(pw , self.view.bounds.size.height/2 + 208, w, imageBottom.size.height* 0.55);
    }
    [_imageViewTop setFrame:frameTop];
    [_imageViewDown setFrame:frameDown];
}

-(void)fristShowTuiGuang
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tuiGuangImgUrl = [defaults objectForKey:@"TuiGuangImgUrl"];
    UIImage *adImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tuiGuangImgUrl]]];
    if (adImage == NULL) {
        adImage = [UIImage imageNamed:@"adBg.png"];
    }
    [_btnImgAd setImage:adImage forState:UIControlStateNormal];
    [self setAdShow:YES];
}

-(void) setAdShow:(BOOL)isShow
{
    if (isShow) {
        [_btnImgAd setHidden:NO];
        [_btnClose setHidden:NO];
    }
    else
    {
        [_btnImgAd setHidden:YES];
        [_btnClose setHidden:YES];
    }
}

-(void)btnImgAdClick:(id)sender
{
    //跳转到对应的链接
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tuiGuangUrl = [defaults objectForKey:@"TuiGuangUrl"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tuiGuangUrl]];
    [defaults synchronize];
}

-(void)btnCloseClick:(id)sender
{
    [self setAdShow:NO];
}

//WebView回调函数
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"gameOver"])
            {
                [self gameOverShow];
            }
//            if([funcStr isEqualToString:@"moreGame"])
//            {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/artist/ray-apps/id410203712"]];
//            }
        }
        //[self addAdmob];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error:%@",error.localizedDescription);
}

-(void)gameOverShow
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *biLi = [defaults objectForKey:@"TuiGuangBiLi"];
    int intBiLi = [biLi intValue];
    NSString *fullIsOpen = [defaults objectForKey:@"AdFullIsOpen"];
    NSString *tuiGuangIsOpen = [defaults objectForKey:@"TuiGuangIsOpen"];
    NSString *adCd = [defaults objectForKey:@"AdCd"];
    int intAdCd = [adCd intValue];
    int cishu = (int)[defaults integerForKey:@"EndTimes"];
    NSString *tuiGuangImgUrl = [defaults objectForKey:@"TuiGuangImgUrl"];
    
    int r = 0;
    if (cishu%intAdCd == 0) {
        r = arc4random() % 10;
        if (r <= intBiLi && ![tuiGuangImgUrl isEqual:@""]) {
            if ([tuiGuangIsOpen isEqual:@"YES"]) {
                UIImage *adImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tuiGuangImgUrl]]];
                if (adImage == NULL) {
                    adImage = [UIImage imageNamed:@"adBg.png"];
                }
                [_btnImgAd setImage:adImage forState:UIControlStateNormal];
                [self setAdShow:YES];
            }
        }
        else
        {
           
        }
    }
    
    cishu = cishu + 1;
    [defaults setInteger:cishu forKey:@"EndTimes"];
    [defaults synchronize];
}

//WebView回调函数



//==============================Admob===============================//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
