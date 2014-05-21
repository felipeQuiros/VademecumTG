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

@property (strong, nonatomic) NSString *detailLabelContents;//le da el nombre al título
@property (strong, nonatomic) UIColor *interfaceColor; //da color a los títulos y objetos
@property (strong, nonatomic) IBOutlet UIImageView *LineColor; //referencia del objeto linea debajo del título
@property (strong, nonatomic) NSString *hexaColor;//variable para guardar el color en formato hexadecimal
@property (strong, nonatomic) IBOutlet UIWebView *htmlContent;//variable con referencia al webview del storyboard
@property (strong, nonatomic) NSString *htmlSource;//variable que almacena el código html mientras es procesado para la carga
@property (strong, nonatomic) NSString *linea;//linea a la que pertenece
@property (strong, nonatomic) NSMutableArray *titles;//arreglo de títulos para mostrar en el action sheet
@property (strong, nonatomic) UIActionSheet *actionSheet;//referencia del action sheet
@property (strong, nonatomic) NSMutableArray *scrolls;//arreglo para guardar los valores de scroll de los títulos en los diferentes medicamentos

- (IBAction)actionSheetButton:(id)sender;//controlador del botón para ejecutal el actionsheet

@end