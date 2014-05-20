//
//  LineasTableViewController.h
//  SearchTry
//
//  Created by SMART MEDIA on 31/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Code by Felipe Quirós

#import <UIKit/UIKit.h>

@interface LineasTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableArray *lista;
@property (strong, nonatomic) NSMutableArray *colors;
@property (strong, nonatomic) NSMutableArray *masterArray;


//arreglos para las listas `:)
@property (strong, nonatomic) NSMutableArray *antiinfecciosos;
@property (strong, nonatomic) NSMutableArray *dermatologicos;
@property (strong, nonatomic) NSMutableArray *preparados;
@property (strong, nonatomic) NSMutableArray *sangre;
@property (strong, nonatomic) NSMutableArray *cardiovascular;
@property (strong, nonatomic) NSMutableArray *musculo;
@property (strong, nonatomic) NSMutableArray *nervioso;
@property (strong, nonatomic) NSMutableArray *respiratorio;
@property (strong, nonatomic) NSMutableArray *alimentario;
@property (strong, nonatomic) NSMutableArray *parasitologia;
@property (strong, nonatomic) NSMutableArray *genitourinario;

@end
