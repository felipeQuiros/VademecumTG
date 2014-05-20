//
//  LineasTableViewController.m
//  SearchTry
//
//  Created by SMART MEDIA on 31/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós

#import "LineasTableViewController.h"
#import "InnerLineTableViewController.h"
#import "Med.h"

@interface LineasTableViewController ()

@end

@implementation LineasTableViewController

- (NSMutableArray *)objects
{
    if(!_objects){
        _objects = [[NSMutableArray alloc] init];
    }
    
    return _objects;
}

- (NSMutableArray *)masterArray
{
    if(!_masterArray){
        _masterArray = [[NSMutableArray alloc] init];
    }
    
    return _masterArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // agregar los objetos
    [self.objects addObject:@"Antiinfecciosos Sistémicos Generales"];
    [self.objects addObject:@"Parasitología"];
    [self.objects addObject:@"Dermatológicos"];
    [self.objects addObject:@"Preparados Hormonales Sintéticos"];
    [self.objects addObject:@"Sangre y Aparato Hematopoyético"];
    [self.objects addObject:@"Sistema Cardiovascular"];
    [self.objects addObject:@"Sistema Genitourinario"];
    [self.objects addObject:@"Sistema Músculo Esquelético"];
    [self.objects addObject:@"Sistema Nervioso Central"];
    [self.objects addObject:@"Sistema Respiratorio"];
    [self.objects addObject:@"Sistema Alimentario y Metabolismo"];
    
    
    self.colors = [[NSMutableArray alloc] initWithObjects:
                     [UIColor colorWithRed:0.9 green:0.51 blue:0.51 alpha:1],
                     [UIColor colorWithRed:0.45 green:0.61 blue:0.84 alpha:1],
                     [UIColor colorWithRed:0.0 green:0.73 blue:0.69 alpha:1],
                     [UIColor colorWithRed:0.62 green:0.84 blue:0.65 alpha:1],
                     [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1],
                     [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1],
                     [UIColor colorWithRed:0.67 green:0.76 blue:0.89 alpha:1],
                     [UIColor colorWithRed:0.58 green:0.86 blue:0.92 alpha:1],
                     [UIColor colorWithRed:0.76 green:0.64 blue:0.82 alpha:1],
                     [UIColor colorWithRed:0.95 green:0.77 blue:0.64 alpha:1],
                     [UIColor colorWithRed:1 green:0.82 blue:0.41 alpha:1],nil];
    
    for(int i=0 ; i<11 ; i++){
        [self.masterArray addObject:[[NSMutableArray alloc] init]];
    }
    
    //load meds
    [self loadTxtSources];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Line" forIndexPath:indexPath];
    
    // Configure the cell...
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\u2022  %@",self.objects[indexPath.row]]];
    [name addAttribute:NSForegroundColorAttributeName value:[self.colors objectAtIndex:indexPath.row] range:NSMakeRange(0, 1)];
    [cell.textLabel setAttributedText:name];
    
    return cell;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   
    if([[segue identifier] isEqualToString:@"ShowLine"])
    {
        NSString *lineName = nil;
        NSIndexPath *indexPath = nil;
        NSMutableArray *arr = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        lineName = self.objects[indexPath.row];
        arr = [self.masterArray objectAtIndex: indexPath.row];
        
        //Aquí le pongo el nombre a la siguiente sección
        [[segue destinationViewController] setDetailLabelContents: lineName];
        [[segue destinationViewController] setObjects: arr];
    }
}

-(void) loadTxtSources{
    
    //NSLog(@"ARRANCO");
    
    
    for (int i=0; i<3; i++) {
        
        //elaborar el string para obtener el txt
        NSString *pp = [NSString stringWithFormat:@"MedSources/Medicamento %i",(i+1)];
        //encuentra la ruta
        NSString *filePath =  [[NSBundle mainBundle] pathForResource: pp ofType:@"txt"];
        
        if(filePath){
            //obtengo el archivo
            NSString *textFromFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            //divido por líneas el archivo
            NSArray *lineSeparatedContent = [textFromFile componentsSeparatedByString:@"\n\n"];
            
            //ESTE OBJETO LO CREE YO :)
            Med *tempMed = [Med new];
            
            //Arreglo para guardar el nombre de las lineas a las que se debe incluir
            NSMutableArray *lineasDelMed = [[NSMutableArray alloc] init];
            
            //cuento las lineas a evaluar
            NSUInteger count = [lineSeparatedContent count];
            //recorro cada línea
            for (NSUInteger j = 0; j < count; j++) {
                NSString *currentString = [lineSeparatedContent objectAtIndex: j];
                
                //NSLog(@"el string a evaluar es: %@",currentString);
                
                if([currentString hasPrefix:@"#&"]){
                    //seteo el nombre quitándole el indicador
                    [tempMed setNombre: [currentString stringByReplacingOccurrencesOfString:@"#&" withString:@""]];
                    //NSLog(@"nombre del med %i es %@",i,[tempMed nombre]);
                }
                
                if([currentString hasPrefix:@"#$"]){
                    //seteo el nuevo parametro de busqueda quitándole el indicador
                    //NSLog(@"lo que se va a agregar es %@",[currentString stringByReplacingOccurrencesOfString:@"#$" withString:@""]);
                    [tempMed addSearchTag: [currentString stringByReplacingOccurrencesOfString:@"#$" withString:@""]];
                }
                
                if([currentString hasPrefix:@"#@"]){
                    //seteo el contenido html del objeto quitándole el indicador
                    //NSLog(@"el contenido html es: %@",[currentString stringByReplacingOccurrencesOfString:@"#@" withString:@""]);
                    [tempMed setHtmlSource:[currentString stringByReplacingOccurrencesOfString:@"#@" withString:@""]];
                }
                
                if([currentString hasPrefix:@"#="]){
                    //seteo la linea a la que pertenecerá quitándole el indicador
                    //NSLog(@"Hace parte de la línea: %@",[currentString stringByReplacingOccurrencesOfString:@"#=" withString:@""]);
                    [lineasDelMed addObject:[currentString stringByReplacingOccurrencesOfString:@"#=" withString:@""]];
                }
                
            }//termina el for que lee el txt
            
            //NSLog(@"%@",[tempMed tags]);//mustra los tags del medicamento
            
            //crea un medicamento seteando la linea a la que pertenece
            for (int i=0; i<lineasDelMed.count; i++) {
                
                //esto es un directorio depronto necesito para agregar meds al array de las lineas
                void (^selectedCase)() = @{
                                           @"Antiinfecciosos Sistémicos Generales" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:0] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                           },
                                           @"Parasitología" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:1] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Dermatológicos" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:2] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Preparados Hormonales Sintéticos" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:3] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sangre y Aparato Hematopoyético" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:4] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Cardiovascular" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:5] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Genitourinario" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:6] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Músculo Esquelético" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:7] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Nervioso Central" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:8] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Respiratorio" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:9] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           @"Sistema Alimentario y Metabolismo" : ^{
                                               [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                                               [[self.masterArray objectAtIndex:10] addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
                                               //NSLog(@" lo que hay ahí metido es:   %@", [self.masterArray objectAtIndex:0]);
                                               
                                           },
                                           }[[lineasDelMed objectAtIndex:i]];
                
                if([lineasDelMed objectAtIndex:i] != nil)
                    selectedCase();
                 
                
            }//fin del for para agregar
        }else{//si no enontró el archivo....
            NSLog(@"no lo logró en el med %i",i);
        }
    }
}





@end
