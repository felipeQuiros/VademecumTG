//
//  DetailViewController.h
//  SearchTry
//
//  Created by SMART MEDIA on 14/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIActionSheetDelegate, UIWebViewDelegate>

@property (strong, nonatomic) NSString *detailLabelContents;
@property (strong, nonatomic) IBOutlet UITextView *contenido;
@property (strong, nonatomic) UIColor *interfaceColor; //da color a los títulos y objetos
@property (strong, nonatomic) IBOutlet UIImageView *LineColor; //referencia del objeto linea debajo del título
@property (strong, nonatomic) NSString *hexaColor;
@property (strong, nonatomic) IBOutlet UIWebView *htmlContent;
@property (strong, nonatomic) NSString *htmlSource;
@property (strong, nonatomic) NSString *linea;//linea a la que pertenece
@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) NSMutableArray *scrolls;

- (IBAction)actionSheetButton:(id)sender;

@end