//
//  JKTEDCrypt.m
//  JKTEDCrypt
//
//  Created by Jeethu on 25/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import "JKTEDCrypt.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation JKTEDCrypt

-(NSData*)encrypt:(NSData*)data
{
    return [self encryptDecrypy:data withIsEn:true];
}
-(NSData*)decrypt:(NSData*)data
{
    return [self encryptDecrypy:data withIsEn:false];
}
-(NSData*)encryptDecrypy:(NSData*)data withIsEn:(BOOL)isEncrypy
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    [[[NSBundle mainBundle] bundleIdentifier] getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t outLength;
    NSMutableData * cipherData = [NSMutableData dataWithLength:data.length + kCCBlockSizeAES128];
    int enDe=0;
    if(!isEncrypy){ enDe=1; }
    CCCryptorStatus
    result = CCCrypt(enDe, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, data.bytes,                     data.length, cipherData.mutableBytes, cipherData.length, &outLength);
    if (result == kCCSuccess) { cipherData.length = outLength; }
    else { return nil; }
    return cipherData;
}
@end
