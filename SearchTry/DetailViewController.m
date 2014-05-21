//
//  DetailViewController.m
//  SearchTry
//
//  Created by SMART MEDIA on 14/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

-(NSMutableArray *)titles//inicialización del arreglo
{
    if(!_titles){
        _titles = [[NSMutableArray alloc] init];
    }
    
    return _titles;
}

-(NSMutableArray *)scrolls//inicialización del arreglo
{
    if(!_scrolls){
        _scrolls = [[NSMutableArray alloc] init];
    }
    
    return _scrolls;
}


- (void)viewDidLoad//primera carga de la interfaz
{
    [super viewDidLoad];//didload del parent
    
    
    //esto no tengo muy claro para qué es pero al parecer es para acceder mediante la variable, a el control del webview
    self.htmlContent.delegate = self;
    
    //set el título de la interfaz (nombre del medicamento)
    self.title = self.detailLabelContents;
    
    //guardo y obtengo el nombre de la línea a la cual pertenece el medicamento en una variable local
    NSString *linea = self.linea;
    
    //esto es un directorio que le dice a la interfaz cómo inicializar los colores dependiendo de su línea
    void (^selectedCase)() = @{
                               @"Antiinfecciosos Sistémicos Generales" : ^{
                                   //rosadito
                                   //NSLog(@"la línea del med seleccionado es: pediátrica");
                                   self.interfaceColor = [UIColor colorWithRed:0.9 green:0.51 blue:0.51 alpha:1];
                                   self.hexaColor = @"h1{color:#E88180;}";
                               },
                               @"Parasitología" : ^{
                                   //fucsia
                                   //NSLog(@"la línea del med seleccionado es: salud femenina");
                                   self.interfaceColor = [UIColor colorWithRed:0.45 green:0.61 blue:0.84 alpha:1];
                                    self.hexaColor = @"h1{color:#7099D3;}";
                               },
                               @"Dermatológicos" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.0 green:0.73 blue:0.69 alpha:1];
                                   self.hexaColor = @"h1{color:#00B5AB;}";
                               },
                               @"Preparados Hormonales Sintéticos" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.62 green:0.84 blue:0.65 alpha:1];
                                   self.hexaColor = @"h1{color:#9DD7A5;}";
                               },
                               @"Sangre y Aparato Hematopoyético" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
                                   self.hexaColor = @"h1{color:#9F9F9F;}";
                               },
                               @"Sistema Cardiovascular" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1];
                                   self.hexaColor = @"h1{color:#AEAEAE;}";
                               },
                               @"Sistema Genitourinario" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.67 green:0.76 blue:0.89 alpha:1];
                                   self.hexaColor = @"h1{color:#B1C9E6;}";
                               },
                               @"Sistema Músculo Esquelético" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.58 green:0.86 blue:0.92 alpha:1];
                                   self.hexaColor = @"h1{color:#95DBEA;}";
                               },
                               @"Sistema Nervioso Central" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.76 green:0.64 blue:0.82 alpha:1];
                                   self.hexaColor = @"h1{color:#C9A9D5;}";
                               },
                               @"Sistema Respiratorio" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.95 green:0.77 blue:0.64 alpha:1];
                                   self.hexaColor = @"h1{color:#F1C3A1;}";
                               },
                               @"Sistema Alimentario y Metabolismo" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:1 green:0.82 blue:0.41 alpha:1];
                                   self.hexaColor = @"h1{color:#FFD36C;}";
                               },
                               }[self.linea];//esta es la variable de la que depende ese diccionario
    
    if(linea != nil)//si tiene un valor
        selectedCase();//llamo el diccionario para que instancie los colores que usaré
    
    //dar color a la linea debajo del título
    if(self.interfaceColor){
        //setear el color del título
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : self.interfaceColor}];
        //setear el color de la línea de abajo del título
        [self.LineColor setBackgroundColor:self.interfaceColor];
    }
    
    //setear el origen del path
    NSString *imagePath = [[NSBundle mainBundle] resourcePath];
    
    //organizar dicho path para ios webURLs
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //obtengo el html entero del txt
    NSMutableString *HTMLData = [NSMutableString stringWithFormat:@"%@",self.htmlSource];
    
    //genero el arreglo para titulos
    //parto el html para que comience con los títulos cada casilla generada
    NSArray *tmparr = [HTMLData componentsSeparatedByString:@"<h1>"];
    
    //NSLog(@"%@",tmparr[1]);
    //NSLog(@"%@",[tmparr[1] substringToIndex: [tmparr[1] rangeOfString:@"<"].location]);
    
    for(int i=0 ; i<[tmparr count]; i++){
        //agrego un string desde el comienzo de cada casilla hasta la primera vez que ocurre el caracter "<"
        if([tmparr[i] length]>1){
            [self.titles addObject:[tmparr[i] substringToIndex: [tmparr[i] rangeOfString:@"<"].location]];
        }
    }
    
    //creo el action sheet vacío
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    //le agrego los botones
    for(int i=0 ; i<[self.titles count] ; i++){
        [self.actionSheet addButtonWithTitle: self.titles[i]];
    }
    //le agreego el botón cancelar :)
    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
    self.actionSheet.title = @"Índice";

    //cargo los estilos
    NSString *pathDeEstilos = @"MedSources/style";
    //encuentra la ruta de los estilos
    NSString *filePath =  [[NSBundle mainBundle] pathForResource: pathDeEstilos ofType:@"txt"];
    
    if(filePath){
        //obtengo el archivo de estilos y lo meto en un nsstring
        NSString *textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        //NSLog(@"los estilos son: %@", textFromFile);
        
        //meter los estilos al htmlData
        [HTMLData insertString:textFromFile atIndex:0];
        
        //adjunto el color para los titulos a dicho string
        [HTMLData insertString:self.hexaColor atIndex:7];
        
        //NSLog(@"*******************  %@",HTMLData);
    }
    
    //cargo el html en mi webview
    [self.htmlContent loadHTMLString:HTMLData baseURL:
     [NSURL URLWithString:
      [NSString stringWithFormat:@"file:/%@//",imagePath]
      ]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /*
     ES IMPORTANTE HACER ESTOS CÁLCULOS EN EL DIDFINISHLOAD PARA QUE TODOS LOS ELEMENTOS DEL HTML EXISTAN Y ENTREGUEN DATOS VERÍDICOS
     */
    
    //se obtiene la longitud del arreglo
    NSString *arrayLenght = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(\"h1\").length;"];
    
    //se usa la longitud del arreglo para hacer un for
    for(int i=0 ; i<[arrayLenght intValue] ; i++){
        //el for usa el index para obtener cada uno de los títulos y su respectivo offset con respecto al top del webview
        NSString *jsQery = [NSString stringWithFormat:@"document.getElementsByTagName(\"h1\")[%i].getBoundingClientRect().top;",i];
        //mando el quer de javascript
        NSString *value = [webView stringByEvaluatingJavaScriptFromString:jsQery];
        //se guarda el numero en un arreglo para usarlo después
        [self.scrolls addObject:[NSNumber numberWithInt:[value intValue]]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSheetButton:(id)sender {
    
    [self.actionSheet showInView: [UIApplication sharedApplication].keyWindow];
    //[actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-( void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //hago un string que contiene el js que voy a hacer, este tiene como objetivo, introducir el valor correcto del arreglo dentro de la función
    //JS que va a scrollear el uiwebview
    NSString *jsQery = [NSString stringWithFormat:@"window.scrollTo(0,%i);", [self.scrolls[buttonIndex] intValue]];
    //mando el JS
    [self.htmlContent stringByEvaluatingJavaScriptFromString: jsQery];
    //NSLog(@"scroll value = %i", [self.scrolls[buttonIndex] intValue]);
    
}

@end
