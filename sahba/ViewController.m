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
    ScreenHeight=self.view.frame.size.height;
    ScreenWidth=self.view.frame.size.width;
    
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
    
    shomareyeGhazalLabel=[[UIButton alloc]initWithFrame:CGRectMake(showView.frame.size.width/4, showView.frame.size.height/7, showView.frame.size.width/2, showView.frame.size.height/15)];
    shomareyeGhazalLabel.backgroundColor=[UIColor redColor];
    [shomareyeGhazalLabel setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
    [showView addSubview:shomareyeGhazalLabel];
    
    ghazalTextView=[[UITextView alloc]initWithFrame:CGRectMake(showView.frame.size.width/6, showView.frame.size.height/4.5, 2*showView.frame.size.width/3, showView.frame.size.height-(showView.frame.size.height/2.8))];
    ghazalTextView.backgroundColor=[UIColor blackColor];
    [showView addSubview:ghazalTextView];
    NSArray* showButtons=[[NSArray alloc]initWithObjects:@"home",@"number",@"fav",@"search",@"plus", nil];
    for (int i=0; i<[showButtons count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/6 +ScreenWidth/10.5, ScreenHeight/1.12, ScreenWidth/6.5, ScreenWidth/6.5)];
        [button setTitle:[showButtons objectAtIndex:i] forState:UIControlStateNormal];
        //[button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        button.layer.cornerRadius= ScreenWidth/13;
        button.backgroundColor=[UIColor redColor];
        [showView addSubview:button];
    }
    //homeButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight/1.09, ScreenWidth/9, ScreenHeight/16)];
    //homeButton.backgroundColor=[UIColor redColor];
    
    
    [self.view addSubview:showView];
    
    
    homeView=[[UIView alloc]initWithFrame:self.view.frame];
    homeImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    homeImageView.image=[UIImage imageNamed:@"home.jpg"];
    [homeView addSubview:homeImageView];
    [self.view addSubview:homeView];
    
    UIImageView* logoView=[[UIImageView alloc]initWithFrame:CGRectMake(homeView.frame.size.width/4, homeView.frame.size.height/3 + homeView.frame.size.height/25 , 4*homeView.frame.size.width/7, homeView.frame.size.height/8)];
   
    logoView.image=[UIImage imageNamed:@"menu-logo.jpg"];
 
    [homeView addSubview:logoView];
    buttonsTitle=[[NSArray alloc]initWithObjects:@"غزل",@"دیباچه",@"فال",@"جست و جو",@"علاقه مندی ها", nil];
   
    
    NSLog(@"height:%f",ScreenHeight);  NSLog(@"height:%f",ScreenWidth);
    
    for (int i=0; i<[buttonsTitle count]; i++) {
      
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4+ 10, ScreenHeight/3 + ScreenHeight/25+ ScreenHeight/8+i*ScreenHeight/15, 3.35*ScreenWidth/7 , ScreenHeight/15)];
      
        // button.backgroundColor=[UIColor colorWithRed:0.5 green:0.8 blue:0.9 alpha:1];
        
        [button setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
        [button setTitle:[buttonsTitle objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [homeView addSubview:button];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [sideMenu addSubview:button];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
    favView.transform=CGAffineTransformMakeTranslation(-favView.frame.size.width, 0);
    dibView.transform=CGAffineTransformMakeTranslation(0, dibView.frame.size.height);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonClicked:(UIButton*)sender{
    if ([sender.titleLabel.text isEqualToString:@"غزل"]) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            showView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"جست و جو"]) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(-homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"علاقه مندی ها"]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            favView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"دیباچه"]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            dibView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(0, -homeView.frame.size.height);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"فال"]) {
        faalView.alpha=0;
        [self.view bringSubviewToFront:faalView];
        [UIView animateWithDuration:0.5 animations:^{
            faalView.alpha=1;
        }];

    }

}
@end
