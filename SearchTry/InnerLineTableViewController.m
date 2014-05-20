//
//  InnerLineTableViewController.m
//  SearchTry
//
//  Created by SMART MEDIA on 31/03/14.
//  Copyright (c) 2014 SMART MEDIA. All rights reserved.
//

#import "InnerLineTableViewController.h"

@interface InnerLineTableViewController ()

@end

@implementation InnerLineTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the title with get
    self.title = self.detailLabelContents;
    
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
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
