//
//  WikiViewController.h
//  WikiApp
//
//  Created by Etay Luz on 1/12/15.
//  Copyright (c) 2015 com.desk.wikiapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WikiViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end
