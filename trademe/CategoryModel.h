//
//  CategoryModel.h
//  trademe
//
//  Created by André Rodrigues on 02/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol CategoryModel;


@interface CategoryModel : JSONModel

@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *Number;
@property (copy, nonatomic) NSString <Optional> *Path;
@property (strong, nonatomic) NSArray <Optional, CategoryModel> *Subcategories;
@property (assign, nonatomic) int AreaOfBusiness;
@property (assign, nonatomic) bool CanHaveSecondCategory;
@property (assign, nonatomic) bool CanBeSecondCategory;
@property (assign, nonatomic) bool IsLeaf;


@end
