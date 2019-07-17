//
//  AppDelegate.h
//  Html5Test
//
//  Created by apple on 14-12-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRecord.h"

@interface AppDelegate : UIResponder  <UIApplicationDelegate,NSXMLParserDelegate>
{
    NSData          *xmlData;
    NSXMLParser     *parserXML;
    NSData          *dataToParse;
    NSMutableArray  *workingArray;
    NSMutableString *workingPropertyString;
    NSArray         *elementsToParse;
    BOOL            storingCharacterData;
    AppRecord       *workingEntry;
}

@property (strong, nonatomic) UIWindow      *window;
@property (nonatomic,retain) NSXMLParser    *parserXML;
@property (nonatomic,retain) NSData         *xmlData;
@property (nonatomic,retain) NSData          *dataToParse;
@property (nonatomic,retain) NSMutableArray  *workingArray;
@property (nonatomic,retain) NSMutableString *workingPropertyString;
@property (nonatomic,retain) NSArray         *elementsToParse;
@property (nonatomic,retain) AppRecord       *workingEntry;
@property (strong, nonatomic) UINavigationController* navigationController;

@end

