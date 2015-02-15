//
//  ViewController.h
//  sahba
//
//  Created by Amin on 2/10/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    float ScreenHeight;
    float ScreenWidth;
    UIView* homeView;
    UIView* showView;
    UIView* dibView;
    UIView* searchView;
    UIView* favView;
    UIView* faalView;
    
    UIImageView* homeImageView;
    UIImageView* showImageView;
    UIImageView* dibImageView;
    UIImageView* searchImageView;
    UIImageView* favImageView;
    UIImageView* faalImageView;
    
    NSArray* buttonsTitle;
    
    UIButton* shomareyeGhazalLabel;
    UITextView* ghazalTextView;
    
    UIButton* homeButton;
    
    
}
@end

