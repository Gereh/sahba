//
//  NSString+NSStringPlus.m
//  PersianCalender
//
//  Created by Helia Taghavi on 7/12/1393 AP.
//  Copyright (c) 1393 Helia Taghavi. All rights reserved.
//

#import "NSString+NSStringPlus.h"

@implementation NSString (NSStringPlus)
-(NSString*)convertNumbersToPersian
{
    NSString *myString = [self stringByReplacingOccurrencesOfString:@"1" withString:@"۱"];
    myString = [myString stringByReplacingOccurrencesOfString:@"2" withString:@"۲"];
    myString =[myString stringByReplacingOccurrencesOfString:@"3" withString:@"۳"];
    myString =[myString stringByReplacingOccurrencesOfString:@"4" withString:@"۴"];
    myString =[myString stringByReplacingOccurrencesOfString:@"5" withString:@"۵"];
    myString =[myString stringByReplacingOccurrencesOfString:@"6" withString:@"۶"];
    myString =[myString stringByReplacingOccurrencesOfString:@"7" withString:@"۷"];
    myString =[myString stringByReplacingOccurrencesOfString:@"8" withString:@"۸"];
    myString =[myString stringByReplacingOccurrencesOfString:@"9" withString:@"۹"];
    myString =[myString stringByReplacingOccurrencesOfString:@"0" withString:@"۰"];
    return myString;
}
-(NSString*)convertNumbersToEnglish
{
    NSString *myString = [self stringByReplacingOccurrencesOfString:@"۱" withString:@"1"];
    myString = [myString stringByReplacingOccurrencesOfString:@"۲" withString:@"2"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۳" withString:@"3"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۴" withString:@"4"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۵" withString:@"5"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۶" withString:@"6"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۷" withString:@"7"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۸" withString:@"8"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۹" withString:@"9"];
    myString =[myString stringByReplacingOccurrencesOfString:@"۰" withString:@"0"];
    return myString;
}

@end
