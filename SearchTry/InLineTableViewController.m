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
