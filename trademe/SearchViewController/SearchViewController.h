//
//  SearchViewController.h
//  trademe
//
//  Created by André Rodrigues on 03/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *region;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIImageView *picture;

@end


@interface SearchViewController : UIViewController

@property (strong, nonatomic) NSString *searchValue;


@end
