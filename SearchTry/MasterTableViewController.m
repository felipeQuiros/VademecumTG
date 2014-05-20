//
//  MasterTableViewController.m
//  SearchTry
//
//  Created by SMART MEDIA on 14/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//

#import "MasterTableViewController.h"
#import "DetailViewController.h"
#import "Med.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

-(NSMutableArray *)objects
{
    if(!_objects){
        _objects = [[NSMutableArray alloc] init];
    }
    
    return _objects;
}

-(NSMutableArray *)results
{
    if(!_results){
        _results = [[NSMutableArray alloc] init];
    }
    
    return _results;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Vademecum TG" message:@"Certifico que soy Médico u Odontólogo." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alertView show];
                              
    
    //load meds
    [self loadTxtSources];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchOnList
{
    self.results = nil;
    
    NSPredicate *predi = [NSPredicate predicateWithFormat:@"tags CONTAINS[c] %@", self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate: predi] mutableCopy];
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchOnList];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    if(tableView == self.tableView){
        return self.objects.count;
    }else{
        
        [self searchOnList];
        return self.results.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //crear la celda que no estaba cerada
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //verificar qué celdas debemos poner dependiendo de la vista actual
    if(tableView == self.tableView){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[self.objects[indexPath.row] nombre],[self.objects[indexPath.row] linea]];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[self.results[indexPath.row] nombre],[self.results[indexPath.row] linea]];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.searchDisplayController.isActive){
        [self performSegueWithIdentifier:@"ShowDetail" sender:self];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    if([[segue identifier] isEqualToString:@"ShowDetail"]){
        NSString *object = nil;
        NSIndexPath *indexPath = nil;
        
        if(self.searchDisplayController.isActive){
            indexPath = [[self.searchDisplayController searchResultsTableView] indexPathForSelectedRow];
            object = [self.results[indexPath.row] nombre];
        }else{
            indexPath = [self.tableView indexPathForSelectedRow];
            object = [self.objects[indexPath.row] nombre];
        }
        
        
        [[segue destinationViewController] setDetailLabelContents:object];
        [[segue destinationViewController] setInterfaceColor:[UIColor colorWithRed:0.9 green:0.51 blue:0.51 alpha:1]];
        [[segue destinationViewController] setHtmlSource:[self.objects[indexPath.row] htmlSource]];
        [[segue destinationViewController] setLinea: [self.objects[indexPath.row] linea]];
        
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
                
                //NSLog(@"el medicamento se va agregar a la linea:  %@", [lineasDelMed objectAtIndex:i]);
                
                [tempMed setLinea:[lineasDelMed objectAtIndex:i]];//le dice a qué línea pertenece
                [self.objects addObject: [tempMed copy]];//lo agrega al arreglo de medicamentos
            }
            
            
        }else{//si no enontró el archivo....
            NSLog(@"no lo logró en el med %i",i);
        }
    }
}

@end
