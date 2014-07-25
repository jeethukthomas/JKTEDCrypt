//
//  ViewController.m
//  JKTEDCrypt
//
//  Created by Jeethu on 25/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import "ViewController.h"
#import "JKTEDCrypt.h"

@interface ViewController ()
- (IBAction)decryptButtonAction:(id)sender;
- (IBAction)encryptButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *en;
@property (strong, nonatomic) IBOutlet UITextField *userText;
@property (strong, nonatomic) IBOutlet UIButton *de;
@property (strong, nonatomic) JKTEDCrypt* jkt;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.jkt = [[JKTEDCrypt alloc] init];
    
    [self.en.layer setBorderWidth:2];
    [self.en.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.en.layer setCornerRadius:50.0];
    [self.de.layer setBorderWidth:2];
    [self.de.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.de.layer setCornerRadius:50.0];
}

- (IBAction)decryptButtonAction:(id)sender {
    NSString* mydestPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSURL* DirURl=[NSURL fileURLWithPath:[mydestPath stringByAppendingPathComponent:@"JKT"] isDirectory:YES];
    mydestPath = [DirURl path] ;
    [fileManager createDirectoryAtURL:DirURl withIntermediateDirectories:YES attributes:nil error:&error];
    mydestPath = [mydestPath stringByAppendingPathComponent:@"JKTencryptFileName"];
    if ([fileManager fileExistsAtPath:mydestPath]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Decrypted Value!"
                                                        message:[NSString stringWithFormat:@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:[self.jkt decrypt:[NSData dataWithContentsOfFile:mydestPath]]]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No data found. Please encrypt first"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)encryptButtonAction:(id)sender {
    
    if(_userText.text.length>0)
    {
        NSString* mydestPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        NSURL* DirURl=[NSURL fileURLWithPath:[mydestPath stringByAppendingPathComponent:@"JKT"] isDirectory:YES];
        mydestPath = [DirURl path] ;
        [fileManager createDirectoryAtURL:DirURl withIntermediateDirectories:YES attributes:nil error:&error];
        mydestPath = [mydestPath stringByAppendingPathComponent:@"JKTencryptFileName"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_userText.text];
        [[self.jkt encrypt:data] writeToFile:mydestPath atomically:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Encrypted Value!"
                                                        message:[NSString stringWithFormat:@"%@",[NSData dataWithContentsOfFile:mydestPath]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
