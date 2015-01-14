//
//  WikiViewController.m
//  WikiApp
//
//  Created by Etay Luz on 1/12/15.
//  Copyright (c) 2015 com.desk.wikiapp. All rights reserved.
//

#import "WikiViewController.h"
#import "WikiTableViewCell.h"
#import "BrowserViewController.h"
@interface WikiViewController ()

@end

@implementation WikiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultsTable.hidden = YES;
    self.resultsTable.showsVerticalScrollIndicator = NO;
    self.searchButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.searchButton.alpha = 0.5;
    self.searchButton.layer.borderWidth = 0.5f;
    self.searchButton.layer.cornerRadius = 3;
    self.searchButton.clipsToBounds = YES;
    self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.searchField.delegate = (id)self;
//    self.searchField.text = @"Test";
}

-(IBAction)searchButtonPressed
{
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
  if (receivedData == nil)
  {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No results" message:[NSString stringWithFormat:@"No results found for entry: \"%@\"", self.searchField.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
  }
  NSDictionary *results = [NSJSONSerialization JSONObjectWithData: receivedData options:kNilOptions error:&error];
  NSDictionary *pageResults = results[@"query"][@"pages"];
  if (pageResults == nil)
  {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No results" message:[NSString stringWithFormat:@"No results found for entry: \"%@\"", self.searchField.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    return;
  }
  self.resultsTable.hidden = NO;

  self.searchResults = [NSMutableArray new];
  for(NSString *page in [pageResults allKeys] )
  {
    [self.searchResults addObject:pageResults[page]];
  }
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
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.pageTitle.text = self.searchResults[indexPath.row][@"title"];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BrowserViewController *broswerViewController = [BrowserViewController new];
  broswerViewController.url = self.searchResults[indexPath.row][@"fullurl"];
  [self presentViewController:broswerViewController animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
  [self.view endEditing:YES];
  [self searchButtonPressed];
  return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
