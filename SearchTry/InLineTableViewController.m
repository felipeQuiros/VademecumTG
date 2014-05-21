//
//  InnerLineTableViewController.m
//  SearchTry
//
//  Created by SMART MEDIA on 31/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//

#import "InLineTableViewController.h"
#import "DetailViewController.h"
#import "Med.h"

@interface InLineTableViewController ()

@end

@implementation InLineTableViewController


- (NSMutableArray *)objects
{
    if(!_objects){
        _objects = [[NSMutableArray alloc] init];
    }
    
    return _objects;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the title with get
    self.title = self.detailLabelContents;
    
    //esto es un directorio que le dice a la interfaz cómo acomodar sus colores
    void (^selectedCase)() = @{
                               @"Antiinfecciosos Sistémicos Generales" : ^{
                                   //rosadito
                                   //NSLog(@"la línea del med seleccionado es: pediátrica");
                                   self.interfaceColor = [UIColor colorWithRed:0.9 green:0.51 blue:0.51 alpha:1];
                               },
                               @"Parasitología" : ^{
                                   //fucsia
                                   //NSLog(@"la línea del med seleccionado es: salud femenina");
                                   self.interfaceColor = [UIColor colorWithRed:0.45 green:0.61 blue:0.84 alpha:1];
                               },
                               @"Dermatológicos" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.0 green:0.73 blue:0.69 alpha:1];
                               },
                               @"Preparados Hormonales Sintéticos" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.62 green:0.84 blue:0.65 alpha:1];
                               },
                               @"Sangre y Aparato Hematopoyético" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
                               },
                               @"Sistema Cardiovascular" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1];
                               },
                               @"Sistema Genitourinario" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.67 green:0.76 blue:0.89 alpha:1];
                               },
                               @"Sistema Músculo Esquelético" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.58 green:0.86 blue:0.92 alpha:1];
                               },
                               @"Sistema Nervioso Central" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.76 green:0.64 blue:0.82 alpha:1];
                               },
                               @"Sistema Respiratorio" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:0.95 green:0.77 blue:0.64 alpha:1];
                               },
                               @"Sistema Alimentario y Metabolismo" : ^{
                                   //azul
                                   //NSLog(@"la línea del med seleccionado es: dermatológica");
                                   self.interfaceColor = [UIColor colorWithRed:1 green:0.82 blue:0.41 alpha:1];
                               },
                               }[self.detailLabelContents];
    
    if(self.detailLabelContents != nil)
        selectedCase();
    
    //dar color a la linea debajo del título
    if(self.interfaceColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : self.interfaceColor}];
        [self.lineCOlor setBackgroundColor:self.interfaceColor];
    }
    
    
    //add meds
    // agregar los objetos
    //[self.objects addObject:@"med 1"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Med" forIndexPath:indexPath];
     
     // Configure the cell...
     Med *tmp = [self.objects objectAtIndex: indexPath.row];
     cell.textLabel.text = [tmp nombre];
     
     return cell;
 }
 


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    if([[segue identifier] isEqualToString:@"ShowMed"])
    {
        NSString *object = nil;
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        Med *tmp = [self.objects objectAtIndex: indexPath.row];
        
        object = [tmp nombre];
        
        //Aquí le pongo el nombre a la siguiente sección
        [[segue destinationViewController] setDetailLabelContents:object];
        [[segue destinationViewController] setInterfaceColor:[UIColor colorWithRed:0.9 green:0.51 blue:0.51 alpha:1]];
        [[segue destinationViewController] setHtmlSource:[self.objects[indexPath.row] htmlSource]];
        [[segue destinationViewController] setLinea: [self.objects[indexPath.row] linea]];
    }
}

@end
