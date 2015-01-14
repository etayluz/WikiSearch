//
//  WikiViewController.m
//  WikiApp
//
//  Created by Etay Luz on 1/12/15.
//  Copyright (c) 2015 com.desk.wikiapp. All rights reserved.
//

#import "WikiViewController.h"
#import "WikiTableViewCell.h"

@interface WikiViewController ()

@end

@implementation WikiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.resultsTable = [[UITableView alloc] init];
//    self.resultsTable.dataSource = self;
//    self.resultsTable.delegate = self;

}

-(IBAction)searchButtonPressed
{
  self.searchField.text = @"Arnold";
  if (self.searchField.text.length == 0)
  {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Search Field Empty" message:@"Please enter search text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
  }
  
  NSError *error;
  NSString *url = [NSString stringWithFormat:@"http://en.wikipedia.org/w/api.php?action=query&generator=search&gsrsearch=%@&format=json&prop=info&inprop=url&gsroffset=0&continue=",self.searchField.text];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
  [request setHTTPMethod:@"GET"];
  NSURLResponse *response = nil;
  NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  self.searchResults = [NSJSONSerialization JSONObjectWithData: receivedData options:kNilOptions error:&error];
  [self.resultsTable reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [self.searchResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"WikiTableViewCell";
  WikiTableViewCell *cell = (WikiTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if(cell == nil){
    cell = [[[NSBundle mainBundle] loadNibNamed:@"WikiTableViewCell" owner:self options:nil] objectAtIndex:0];
  }
  cell.pageTitle.text = [@(indexPath.row) stringValue];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
