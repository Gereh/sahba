//
//  ViewController.m
//  sahba
//
//  Created by Amin on 2/10/15.
//  Copyright (c) 2015 Reza Sazegarnezhad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    faalView=[[UIView alloc]initWithFrame:self.view.frame];
    faalImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    faalImageView.image=[UIImage imageNamed:@"fall.jpg"];
    [faalView addSubview:faalImageView];
    [self.view addSubview:faalView];
    
    favView=[[UIView alloc]initWithFrame:self.view.frame];
    favImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    favImageView.image=[UIImage imageNamed:@"fav.jpg"];
    [favView addSubview:favImageView];
    [self.view addSubview:favView];
    
    searchView=[[UIView alloc]initWithFrame:self.view.frame];
    searchImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    searchImageView.image=[UIImage imageNamed:@"search.jpg"];
    [searchView addSubview:searchImageView];
    [self.view addSubview:searchView];
    
    dibView=[[UIView alloc]initWithFrame:self.view.frame];
    dibImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    dibImageView.image=[UIImage imageNamed:@"dib.jpg"];
    [dibView addSubview:dibImageView];
    [self.view addSubview:dibView];
    
    showView=[[UIView alloc]initWithFrame:self.view.frame];
    showImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    showImageView.image=[UIImage imageNamed:@"show.jpg"];
    [showView addSubview:showImageView];
    [self.view addSubview:showView];
    
    homeView=[[UIView alloc]initWithFrame:self.view.frame];
    homeImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    homeImageView.image=[UIImage imageNamed:@"home.jpg"];
    [homeView addSubview:homeImageView];
    [self.view addSubview:homeView];
    
    UIImageView* logoView=[[UIImageView alloc]initWithFrame:CGRectMake(homeView.frame.size.width/4, homeView.frame.size.height/3 + homeView.frame.size.height/25 , homeView.frame.size.width/2+20, homeView.frame.size.height/8)];
    logoView.image=[UIImage imageNamed:@"menu-logo.jpg"];
    [homeView addSubview:logoView];
    buttonsTitle=[[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
//    for (int i=1; i<[buttonsTitle count]; i++) {
//        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(homeView.frame.size.width/4+ 10, homeView.frame.size.height/3 + (i+1)*homeView.frame.size.height/15 , homeView.frame.size.width/2, homeView.frame.size.height/15)];
//        button.backgroundColor=[UIColor colorWithRed:0.5 green:0.8 blue:0.9 alpha:1];
//        
//        [button setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
//        [button setTitle:[buttonsTitle objectAtIndex:i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [homeView addSubview:button];
////        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
////        [sideMenu addSubview:button];
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
