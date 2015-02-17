//
//  ViewController.h
//  sahba
//
//  Created by Amin on 2/10/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NSString+NSStringPlus.h"


@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSArray* verses;
    NSInteger state;
    float ScreenHeight;
    float ScreenWidth;
    UIView* homeView;
    UIView* showView;
    UIView* dibView;
    UIView* searchView;
    UIView* favView;
    UIView* faalView;
    UIView* pickNumberView;
    
    UIImageView* homeImageView;
    UIImageView* showImageView;
    UIImageView* dibImageView;
    UIImageView* searchImageView;
    UIImageView* favImageView;
    UIImageView* faalImageView;
    
    NSArray* buttonsTitle;
    
    UIButton* shomareyeGhazalLabel;
    UITextView* ghazalTextView;
    UITextField* pickTextField;
    BOOL favoriteOn;
    NSMutableArray* favoriteVerses;
    UITableView* favoriteTable;
    NSString* fileAddress;
    
    BOOL isSearching;
    UISearchBar* mySearchBar;
    NSMutableArray* searchResult;
    NSString* searchsearch;
    UITableView* searchTable;
    NSString* searchString;
    NSInteger select;
    
    UIView* plusView;
    BOOL plusIsOn;
    
    NSMutableArray* horizontalButtons;
    NSMutableArray* verticalButtons;
    
    float fontState;
    
    UITapGestureRecognizer* tap;
    UILabel* notFound;
    
    UITapGestureRecognizer* tapOnSearchView;
    BOOL isOnShowPage;
    UIButton* searchBack;
    UITextView* zendeginaameTextView;
    UIButton* favoriteBack;
    UIButton* dibacheBack;
    UIButton* faalBack;
    
    int random;
    BOOL faalOn;
    
    UISwipeGestureRecognizer* right;
    UISwipeGestureRecognizer* left;
    
    NSArray* horizontalIconImage;
    NSArray* verticalIconImage;
    UITapGestureRecognizer* tapOnNumbers;
    
}
-(void)shakeView ;

@end

