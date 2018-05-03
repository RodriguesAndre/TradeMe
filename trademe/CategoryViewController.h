//
//  ViewController.h
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryModel;

@interface CategoryViewController : UIViewController

- (instancetype)initWithCategories:(NSArray <CategoryModel *> *)categories;

@end

