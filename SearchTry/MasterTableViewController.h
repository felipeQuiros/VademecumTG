//
//  MasterTableViewController.h
//  SearchTry
//
//  Created by SMART MEDIA on 14/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//  Coded by Felipe Quirós
//

#import <UIKit/UIKit.h>

@interface MasterTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@end

