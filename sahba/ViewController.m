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
    
      faalOn=NO;
    isOnShowPage=NO;
    plusIsOn=NO;
    isSearching=NO;
    favoriteOn=NO;
    state=1;
    fontState=11;
    ScreenHeight=self.view.frame.size.height;
    ScreenWidth=self.view.frame.size.width;
    
    horizontalIconImage=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"home.png"],[UIImage imageNamed:@"go-num.png"],[UIImage imageNamed:@"like.png"],[UIImage imageNamed:@"search.png"],[UIImage imageNamed:@"plus.png"], nil];
    verticalIconImage=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"font-plus.png"], [UIImage imageNamed:@"font-minus.png"],[UIImage imageNamed:@"share.png"], nil];
    
    NSString* homeDirectory=NSHomeDirectory();
    NSString* documentDirectory=[homeDirectory stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",documentDirectory);
    NSFileManager* filemanager=[[NSFileManager alloc]init];
    
    NSString* address=[[NSBundle mainBundle]pathForResource:@"hafez" ofType:@"txt"];
    NSString* divaan=[NSString stringWithContentsOfFile:address encoding:NSUTF8StringEncoding error:nil];
    verses=[divaan componentsSeparatedByString:@"****"];
    
    NSString* fileName=[documentDirectory stringByAppendingPathComponent:@"myFavorites"];
    fileAddress=[fileName stringByAppendingPathExtension:@"txt"];
    if ([filemanager fileExistsAtPath:fileAddress]) {
        favoriteVerses=[[NSMutableArray alloc]initWithContentsOfFile:fileAddress];
    }
    else
    {
        favoriteVerses=[[NSMutableArray alloc]init];
    }
    
    faalView=[[UIView alloc]initWithFrame:self.view.frame];
    faalImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    faalImageView.image=[UIImage imageNamed:@"fall.jpg"];
    [faalView addSubview:faalImageView];
    [self.view addSubview:faalView];
    faalView.alpha=0;
    
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
    
    UIImageView* logoView=[[UIImageView alloc]initWithFrame:CGRectMake(homeView.frame.size.width/4, homeView.frame.size.height/3 + homeView.frame.size.height/25 , 4*homeView.frame.size.width/7, homeView.frame.size.height/8)];
   
    logoView.image=[UIImage imageNamed:@"menu-logo.jpg"];
 
    [homeView addSubview:logoView];
    buttonsTitle=[[NSArray alloc]initWithObjects:@"غزلیات حافظ",@"زندگی نامه",@"فال",@"جست و جو",@"علاقه مندی ها", nil];
   
    
    NSLog(@"height:%f",ScreenHeight);  NSLog(@"height:%f",ScreenWidth);
    
    for (int i=0; i<[buttonsTitle count]; i++) {
      
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4+ 10, ScreenHeight/3 + ScreenHeight/25+ ScreenHeight/8+i*ScreenHeight/15, 3.35*ScreenWidth/7 , ScreenHeight/15)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:0.027 green:0.423 blue:0.603 alpha:1] forState:UIControlStateHighlighted];
        
        [button setTitle:[buttonsTitle objectAtIndex:i] forState:UIControlStateNormal];
       
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.titleLabel.font=    [UIFont fontWithName:@"Iranian Sans" size:20];
        
        
       
        [homeView addSubview:button];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //adding search table to search view
    searchResult=[[NSMutableArray alloc]init];
    mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(ScreenWidth/4.5,ScreenHeight/3.5,2*ScreenWidth/3, 1.5*ScreenHeight/18)];
//    mySearchBar.layer.borderColor=[[UIColor blackColor]CGColor];
//    mySearchBar.layer.borderWidth=2;
    mySearchBar.delegate=self;
    [mySearchBar setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"]];
    [mySearchBar setTranslucent:YES];

    [searchView addSubview:mySearchBar];
    UIButton* searchButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth/9, ScreenHeight/2.8, ScreenWidth/4,ScreenHeight/18)];
    searchButton.layer.cornerRadius=10;
    [searchButton setTitle:@"جست و جو" forState:UIControlStateNormal];
    searchButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchButton.backgroundColor=[UIColor grayColor];
    [searchButton addTarget:self action:@selector(searchBarSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //[searchView addSubview:searchButton];
    searchBack=[[UIButton alloc]initWithFrame:CGRectMake(4*ScreenWidth/5, ScreenHeight/9, ScreenHeight/11,ScreenHeight/11)];
    [searchBack addTarget:self action:@selector(searchBack:) forControlEvents:UIControlEventTouchUpInside];
    [searchBack setBackgroundImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    searchBack.layer.cornerRadius=ScreenHeight/22;
    searchBack.backgroundColor=[UIColor grayColor];
    [searchView addSubview:searchBack];
    searchTable=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/4.5,ScreenHeight/2.8,2*ScreenWidth/3, ScreenHeight/2) style:UITableViewStylePlain];
    
    searchResult=[[NSMutableArray alloc]init];

    searchTable.delegate=self;
    searchTable.dataSource=self;
    [searchTable setAllowsSelection:YES];
    notFound=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4.5,ScreenHeight/2.3,2*ScreenWidth/3, ScreenHeight/4)];
    notFound.textAlignment=NSTextAlignmentCenter;
    notFound.textColor=[UIColor blackColor];
    [searchView addSubview:notFound];
    [searchView addSubview:searchTable];
    searchTable.alpha=0;
    
    
    shomareyeGhazalLabel=[[UIButton alloc]initWithFrame:CGRectMake(showView.frame.size.width/4, showView.frame.size.height/7, showView.frame.size.width/2, showView.frame.size.height/15)];
    //shomareyeGhazalLabel.backgroundColor=[UIColor blueColor];
    [shomareyeGhazalLabel setBackgroundImage:[UIImage imageNamed:@"ghazal-num-back.png"] forState:UIControlStateNormal];
    [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
    shomareyeGhazalLabel.titleLabel.font=[UIFont fontWithName:@"Iranian Sans" size:20];
    [shomareyeGhazalLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showView addSubview:shomareyeGhazalLabel];
    
    ghazalTextView=[[UITextView alloc]initWithFrame:CGRectMake(showView.frame.size.width/7, showView.frame.size.height/4.5, 2.15*showView.frame.size.width/3, showView.frame.size.height-(showView.frame.size.height/2.8))];
    ghazalTextView.text=[verses objectAtIndex:state];
    ghazalTextView.font=[UIFont fontWithName:@"Iranian Sans" size:fontState];
    [ghazalTextView setBackgroundColor:[UIColor clearColor]];
    ghazalTextView.editable=NO;
    ghazalTextView.textAlignment=NSTextAlignmentCenter;
    [showView addSubview:ghazalTextView];
    NSArray* showPageButtons=[[NSArray alloc]initWithObjects:@"home",@"number",@"fav",@"search",@"plus", nil];
    horizontalButtons=[[NSMutableArray alloc]init];
    for (int i=0; i<[showPageButtons count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/6 +ScreenWidth/10.5, ScreenHeight/1.12, ScreenWidth/6.5, ScreenWidth/6.5)];
        [button setTitle:[showPageButtons objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        button.layer.cornerRadius= ScreenWidth/13;
        button.backgroundColor=[UIColor blueColor];
        
        //button.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
        [button setBackgroundImage:[horizontalIconImage objectAtIndex:i] forState:UIControlStateNormal];
        [showView addSubview:button];
        [button addTarget:self action:@selector(horizontalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [horizontalButtons addObject:button];
    }
    
    //creating subviews of show view
    next=[[UIButton alloc]initWithFrame:CGRectMake(0.01*showView.frame.size.width/9, 1.25*showView.frame.size.height/3, showView.frame.size.height/7, showView.frame.size.height/7)];
    next.alpha=0.5;
    [next setBackgroundImage:[UIImage imageNamed:@"per-button.png"] forState:UIControlStateNormal];
    //  next.layer.cornerRadius=(showView.frame.size.height/15)/2;
    [next addTarget:self action:@selector(goToNext:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:next];
    
    previous=[[UIButton alloc]initWithFrame:CGRectMake(5.5*showView.frame.size.width/7,1.25*showView.frame.size.height/3, showView.frame.size.height/7, showView.frame.size.height/7)];
    previous.alpha=0.5;
    
    [previous setBackgroundImage:[UIImage imageNamed:@"next-button.png"] forState:UIControlStateNormal];
    //  previous.layer.cornerRadius=(showView.frame.size.height/15)/2;
    [previous addTarget:self action:@selector(goToPrevious:) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:previous];
    
    pickNumberView=[[UIView alloc]initWithFrame:showView.frame];
    pickNumberView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.7];
    pick=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5.5*ScreenWidth/8, 2*ScreenHeight/8 )];
    
    UIImage* pickerViewBackgroundImage=[UIImage imageNamed:@"back2.png"];
    UIImageView* pickerViewBackground=[[UIImageView alloc]initWithFrame:pick.frame];
    pickerViewBackground.image=pickerViewBackgroundImage;
    [pick addSubview:pickerViewBackground];

    
    pick.layer.cornerRadius=10;
   
    pickTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 1*pick.frame.size.height/3,  5*ScreenWidth/8, ScreenHeight/20)];
    pickTextField.borderStyle=UITextBorderStyleNone;
    pickTextField.placeholder=@"شماره غزل را وارد کنید...";
    pickTextField.font=[UIFont fontWithName:@"Iranian Sans" size:12];
    pickTextField.textAlignment=NSTextAlignmentCenter;
    pickTextField.delegate=self;
    [pick addSubview:pickTextField];
    pick.center=CGPointMake(ScreenWidth/2, ScreenHeight/3);
    [pickNumberView addSubview:pick];
    
    UIButton* goButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/7, ScreenWidth/7)];
    goButton.backgroundColor=[UIColor blackColor];
    goButton.center=CGPointMake(pick.frame.size.width/2, 2*pick.frame.size.height/3+10+5);
    [goButton setTitle:@"برو" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [goButton setBackgroundImage:[UIImage imageNamed:@"go.png"] forState:UIControlStateNormal];
    goButton.titleLabel.font=[UIFont fontWithName:@"Iranian Sans" size:15];;
    goButton.layer.cornerRadius=ScreenWidth/14;
    [goButton addTarget:self action:@selector(goToVerse) forControlEvents:UIControlEventTouchUpInside];
    
    [pick addSubview:goButton];
    [showView addSubview:pickNumberView];
    pickNumberView.alpha=0;
    
    
    plusView=[[UIView alloc]initWithFrame:self.view.frame];
    plusView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.7];
    NSArray* ButtonsOnPlus=[[NSArray alloc]initWithObjects:@"T+",@"T-",@"share", nil];
    verticalButtons=[[NSMutableArray alloc]init];
    for (int i=0; i<[ButtonsOnPlus count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/1.3, ScreenHeight/1.3 -(i*ScreenHeight/9), ScreenWidth/7, ScreenWidth/7)];
        [button setTitle:[ButtonsOnPlus objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        button.layer.cornerRadius=ScreenWidth/14;
        [button setBackgroundImage:[verticalIconImage objectAtIndex:i] forState:UIControlStateNormal];
        [plusView addSubview:button];
        button.alpha=0;
        [verticalButtons addObject:button];
        [button addTarget:self action:@selector(verticalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [showView addSubview:plusView];
    [showView bringSubviewToFront:[horizontalButtons objectAtIndex:4]];
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPlusView)];
    tap.delegate=self;
    [plusView addGestureRecognizer:tap];
    plusView.alpha=0;
    if ([favoriteVerses containsObject:@"1"]) {
        [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
    }
    
    // creating favorite table
    UIButton* favoriteTableTitle=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/9,ScreenHeight/4,2*ScreenWidth/3, ScreenHeight/18)];
    [favoriteTableTitle setTitle:@"غزل های مورد علاقه" forState:UIControlStateNormal];

    favoriteTableTitle.titleLabel.font=[UIFont fontWithName:@"Iranian Sans" size:18];

    
    [favoriteTableTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [favoriteTableTitle setBackgroundImage:[UIImage imageNamed:@"ghazal-num-back.png"] forState:UIControlStateNormal ];
    
    [favView addSubview:favoriteTableTitle];
    favoriteTable=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/9,ScreenHeight/3,2*ScreenWidth/3, ScreenHeight/2) style:UITableViewStylePlain];

    favoriteTable.delegate=self;
    favoriteTable.dataSource=self;
    [favoriteTable setAllowsSelection:YES];
    favoriteTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [favView addSubview:favoriteTable];
    
    tapOnSearchView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnSearchView:)];
    [searchView addGestureRecognizer:tapOnSearchView];
    
    NSString* zendeginameAddress=[[NSBundle mainBundle]pathForResource:@"zendeginameh" ofType:@"txt"];
    NSString* zendeginame=[NSString stringWithContentsOfFile:zendeginameAddress encoding:NSUTF8StringEncoding error:nil];
    zendeginaameTextView=[[UITextView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight/5, 5*ScreenWidth/7, 4.3*ScreenHeight/8)];
    
    zendeginaameTextView.text=zendeginame;
    zendeginaameTextView.textAlignment=NSTextAlignmentJustified;
    
    zendeginaameTextView.font=[UIFont fontWithName:@"Iranian Sans" size:13];
   
    zendeginaameTextView.editable=NO;

    UIBezierPath* aObjBezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 20)];
    zendeginaameTextView.textContainer.exclusionPaths = @[aObjBezierPath];
    [dibView addSubview:zendeginaameTextView];
    
    dibacheBack=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/10, ScreenHeight/9, ScreenHeight/11,ScreenHeight/11)];
    [dibacheBack addTarget:self action:@selector(dibacheBack:) forControlEvents:UIControlEventTouchUpInside];
    dibacheBack.titleLabel.font=[UIFont fontWithName:@"Iranian Sans" size:15];;
    dibacheBack.layer.cornerRadius=ScreenHeight/22;
    [dibacheBack setBackgroundImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    [dibView addSubview:dibacheBack];
    
    favoriteBack=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/10, ScreenHeight/9, ScreenHeight/11,ScreenHeight/11)];
    [favoriteBack addTarget:self action:@selector(favoriteBack:) forControlEvents:UIControlEventTouchUpInside];
    [favoriteBack setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    favoriteBack.layer.cornerRadius=ScreenHeight/22;
    favoriteBack.backgroundColor=[UIColor grayColor];
    [favView addSubview:favoriteBack];
    
    faalBack=[[UIButton alloc]initWithFrame:CGRectMake(4.95*ScreenWidth/6, ScreenHeight/40, ScreenHeight/11,ScreenHeight/11)];
    [faalBack addTarget:self action:@selector(faalBack:) forControlEvents:UIControlEventTouchUpInside];
    faalBack.layer.cornerRadius=ScreenHeight/22;
    faalBack.backgroundColor=[UIColor clearColor];
    [faalView addSubview:faalBack];
    
    tapOnNumbers=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss123:)];
    tapOnNumbers.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.

    showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
    favView.transform=CGAffineTransformMakeTranslation(-favView.frame.size.width, 0);
    dibView.transform=CGAffineTransformMakeTranslation(0, dibView.frame.size.height);


}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewDidLoad");
    

  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)buttonClicked:(UIButton*)sender{
   // [sender setEnabled:NO];
    isOnShowPage=YES;
    showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    if ([sender.titleLabel.text isEqualToString:@"غزلیات حافظ"]) {
        [UIView animateWithDuration:0.4 animations:^{
            showView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"جست و جو"]) {
        isOnShowPage=NO;
        notFound.alpha=1;
        notFound.text=@"عبارت مورد نظر را جست و جو کنید";
        searchTable.alpha=0;
        [searchTable reloadData];
        isSearching=YES;
        searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(-homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"علاقه مندی ها"]) {
        NSLog(@"%@",favoriteVerses);
        favoriteOn=YES;
        [favoriteTable reloadData];
        favView.transform=CGAffineTransformMakeTranslation(-favView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            favView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"زندگی نامه"]) {
        dibView.transform=CGAffineTransformMakeTranslation(0, dibView.frame.size.height);
        [UIView animateWithDuration:0.4 animations:^{
            dibView.transform=CGAffineTransformMakeTranslation(0, 0);
            homeView.transform=CGAffineTransformMakeTranslation(0, -homeView.frame.size.height);
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"فال"]) {
        faalOn=YES;
        faalView.alpha=0;
        [self.view bringSubviewToFront:faalView];
        [UIView animateWithDuration:0.4 animations:^{
            faalView.alpha=1;
        }];
        
    }
    
}
-(void)goToVerse{
    if (![pickTextField.text isEqualToString: @""]) {
        pickTextField.backgroundColor=[UIColor whiteColor];
        if (1<=[pickTextField.text integerValue] && [pickTextField.text integerValue]<=495) {
            //NSLog(@"integer Value:%li",(long)[pickTextField.text integerValue]);
            state=[pickTextField.text integerValue];
            NSLog(@"%@",pickTextField.text);
            BOOL alreadyHas=NO;
            for (NSString* apart in favoriteVerses) {
                if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                    alreadyHas=YES;
                    break;
                }
            }
            if (!alreadyHas) {
                [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
                NSLog(@"not already has");
            }
            else{
                NSLog(@"already has");

                [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
            }
            ghazalTextView.text=[verses objectAtIndex:state];
            [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.1 animations:^{
                pickNumberView.alpha=0;
            }];
            [pickTextField resignFirstResponder];
            pickTextField.text=nil;
            [UIView animateWithDuration:0.2 animations:^{
                pickNumberView.alpha=0;
            }];
            [pickTextField resignFirstResponder];
            pickTextField.text=nil;

        }
        else{
                [self shakeView];
            pickTextField.text=@"";
            
        
        }
         
    

    }
    
    
    
}
-(void)tapOnPlusView
{
    [self plusButtonClicked];
}

#pragma mark tableview methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return [searchResult count];
    }
    if (favoriteOn) {
        return [favoriteVerses count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    select=indexPath.row;
    if (tableView==searchTable) {
        NSLog(@"search");
        if (isSearching) {
            
            if (searchResult.count> indexPath.row) {
                select=((NSString*)[searchResult objectAtIndex: indexPath.row]).integerValue;
            }
            else
                return cell;
            NSArray* versComp=[(NSString*)[verses objectAtIndex:select] componentsSeparatedByString:@"\n"];
            for (NSString* apart in versComp) {
                if ([apart containsString:searchString]) {
                    cell.textLabel.text=apart;
                    break;
                }
            }
            
        }
    }
    if (tableView==favoriteTable) {
        NSLog(@"fav");
        if (favoriteVerses.count> indexPath.row) {
            select=((NSString*)[favoriteVerses objectAtIndex:indexPath.row]).integerValue;
        }
        else
            return cell;
        NSArray* versComp=[(NSString*)[verses objectAtIndex:select] componentsSeparatedByString:@"\n"];
        cell.textLabel.text=[versComp objectAtIndex:2];
        
    }
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tableView setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]]];
    
    
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.textLabel.font=[UIFont fontWithName:@"Iranian Sans" size:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    select=indexPath.row;
    if (tableView==searchTable) {
        if (isSearching) {
            
            if (searchResult.count> indexPath.row) {
                select=((NSString*)[searchResult objectAtIndex: indexPath.row]).integerValue;
            }
        }
        state=select;
        ghazalTextView.text=[verses objectAtIndex:state];
        BOOL alreadyHas=NO;
        for (NSString* apart in favoriteVerses) {
            if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                alreadyHas=YES;
                break;
            }
        }
        if (!alreadyHas) {
            NSLog(@"has not");
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
        }
        else{
            NSLog(@"has");
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
        }

        [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
        
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
            showView.transform=CGAffineTransformMakeTranslation(0, 0);
            mySearchBar.text=nil;
        }];
    }
    if (tableView==favoriteTable) {
            
        if (favoriteVerses.count> indexPath.row) {
                select=((NSString*)[favoriteVerses objectAtIndex: indexPath.row]).integerValue;
        }
        BOOL alreadyHas=NO;
        state=select;
        for (NSString* apart in favoriteVerses) {
            if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                alreadyHas=YES;
                break;
            }
        }
        if (!alreadyHas) {
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
        }
        else{
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
        }
        [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
        ghazalTextView.text=[verses objectAtIndex:state];
        showView.transform=CGAffineTransformMakeTranslation(showView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            favView.transform=CGAffineTransformMakeTranslation(-favView.frame.size.width, 0);
            showView.transform=CGAffineTransformMakeTranslation(0, 0);
            
        }];
    }
    [mySearchBar resignFirstResponder];
    isSearching=NO;
    favoriteOn=NO;
}

#pragma mark actions-For-Horizontal-Buttons
-(void)horizontalButtonClicked:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"home"]) {
        [self homeButtonClicked];
    }
    if ([sender.titleLabel.text isEqualToString:@"number"]) {
        [self numberButtonClicked];
    }
    if ([sender.titleLabel.text isEqualToString:@"fav"]) {
        [self addToFavorite:sender];
    }
    if ([sender.titleLabel.text isEqualToString:@"search"]) {
        [self searchButtonClicked];
    }
    if ([sender.titleLabel.text isEqualToString:@"plus"]) {
        [self plusButtonClicked];
    }
}
-(void)homeButtonClicked
{
    isOnShowPage=NO;
    homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
    [UIView animateWithDuration:0.4 animations:^{
        homeView.transform=CGAffineTransformMakeTranslation(0, 0);
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    }];
}
-(void)searchButtonClicked
{
    isOnShowPage=YES;
    notFound.text=@"عبارت مورد نظر را جست و جو کنید";
    notFound.alpha=1;
    searchTable.alpha=0;
    isSearching=YES;
    [searchResult removeAllObjects];
    [searchTable reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        searchView.transform=CGAffineTransformMakeTranslation(0, 0);
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    }];

}
-(void)numberButtonClicked
{
    [UIView animateWithDuration:0.1 animations:^{
        pickNumberView.alpha=1;
    }];
    [pickNumberView addGestureRecognizer:tapOnNumbers];
    [pick removeGestureRecognizer:tapOnNumbers];
    
}
-(void)addToFavorite:(UIButton*)sender;
{
    BOOL alreadyHas=NO;
    
    for (NSString* apart in favoriteVerses) {
        if ([[NSString stringWithFormat:@"%li",(long)state] isEqualToString: apart]) {
            alreadyHas=YES;
        }
    }
    if (!alreadyHas) {
        [favoriteVerses addObject:[NSString stringWithFormat:@"%li",(long)state]];
        [sender setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        // [sender setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    }
    else{
        [favoriteVerses removeObject:[NSString stringWithFormat:@"%li",(long)state]];
        [sender setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        //[sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [favoriteVerses writeToFile:fileAddress atomically:YES];
}
-(void)plusButtonClicked
{
    if (!plusIsOn) {
        [((UIButton*)[horizontalButtons objectAtIndex:4]) setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            plusView.alpha=1;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                ((UIButton*)[verticalButtons objectAtIndex:0]).alpha=1;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    ((UIButton*)[verticalButtons objectAtIndex:1]).alpha=1;
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        ((UIButton*)[verticalButtons objectAtIndex:2]).alpha=1;
                    }completion:^(BOOL finished) {
                        plusIsOn=YES;
                    }];
                }];
            }];
        }];
    }
    else
    {
        [((UIButton*)[horizontalButtons objectAtIndex:4]) setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            plusView.alpha=0;
        }completion:^(BOOL finished) {
            ((UIButton*)[verticalButtons objectAtIndex:0]).alpha=0;
            ((UIButton*)[verticalButtons objectAtIndex:1]).alpha=0;
            ((UIButton*)[verticalButtons objectAtIndex:2]).alpha=0;
            plusIsOn=NO;
        }];
    }
    
}


#pragma mark actions-For-Vertical-Buttons
-(IBAction)verticalButtonClicked:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"T+"]) {
        [self fontPlusAction];
    }
    else if ([sender.titleLabel.text isEqualToString:@"T-"]) {
        [self fontMinusAction];
    }
    else if ([sender.titleLabel.text isEqualToString:@"share"]) {
        [self share:sender];
    }
}
-(void)fontPlusAction{
    if (fontState < 16) {
        fontState++;
        ghazalTextView.font=[UIFont fontWithName:@"Iranian Sans" size:fontState];
    }
}
-(void)fontMinusAction{
    
    if (fontState > 10) {
        fontState--;
        ghazalTextView.font=[UIFont fontWithName:@"Iranian Sans" size:fontState];
    }
}
-(IBAction)share:(UIButton*)sender
{
    NSString *textToShare=ghazalTextView.text;
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.google.com"];
    
    
  
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[textToShare,myWebsite ]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController
                       animated:YES
                     completion:^{
                         if ([activityViewController respondsToSelector:@selector(popoverPresentationController)])
                         {
                             UIPopoverPresentationController *presentationController = [activityViewController popoverPresentationController];
                             
                             presentationController.sourceView = sender;
                         }
                     }];
    

}
#pragma mark search methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [searchResult removeAllObjects];
    [searchTable reloadData];
    notFound.alpha=0;
    searchTable.alpha=1;

    if([[NSString stringWithFormat:@"%c",[searchText characterAtIndex:(searchText.length)-1] ] isEqualToString:@" "] )
    {
        searchText=[searchText substringToIndex:searchText.length-1];
    }
    
    searchText=[searchText stringByReplacingOccurrencesOfString:@"ی" withString:@"ي"];
    searchText=[searchText stringByReplacingOccurrencesOfString:@"ك" withString:@"ک"];
    NSString* mystring;
    for (int i=0; i <[verses count]; i++) {
        mystring=[verses objectAtIndex:i];
        if ([[mystring lowercaseString]  containsString:[searchText lowercaseString]]) {
            [searchResult addObject:[NSString stringWithFormat:@"%i", i]];
        }
        searchsearch=searchText;
        [searchTable reloadData];
        
    }
    if (!mySearchBar.text) {
        notFound.text=@"عبارت مورد نظر را جست و جو کنید";
    }
    else if (searchResult.count==0) {
        notFound.text=@"ای عزیز غزلت یافت نشد!";
        searchTable.alpha=0;
        notFound.alpha=1;
    }
    searchString=searchText;
    [searchTable reloadData];
    //[searchView addSubview:searchTable];
    isSearching=YES;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mySearchBar resignFirstResponder];
    [searchView removeGestureRecognizer:tapOnSearchView];
    
}
-(void)tappedOnSearchView:(UIGestureRecognizer*)sender{
    [mySearchBar resignFirstResponder];
    [searchView removeGestureRecognizer:tapOnSearchView];
}
-(void)searchBack:(UIButton*)sender
{
    [mySearchBar resignFirstResponder];
    isSearching=NO;
    mySearchBar.text=nil;
    if (isOnShowPage) {
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
            showView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
    }
    else{
        homeView.transform=CGAffineTransformMakeTranslation(-homeView.frame.size.width, 0);
        [UIView animateWithDuration:0.4 animations:^{
            searchView.transform=CGAffineTransformMakeTranslation(searchView.frame.size.width, 0);
            homeView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
    }
}
-(void)favoriteBack:(UIButton*)sender
{
    homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
    [UIView animateWithDuration:0.4 animations:^{
        favView.transform=CGAffineTransformMakeTranslation(-favView.frame.size.width, 0);
        homeView.transform=CGAffineTransformMakeTranslation(0, 0);
    }];
}
-(void)dibacheBack:(UIButton*)sender{
    homeView.transform=CGAffineTransformMakeTranslation(0, -homeView.frame.size.height);
    [UIView animateWithDuration:0.4 animations:^{
        dibView.transform=CGAffineTransformMakeTranslation(0, dibView.frame.size.height);
        homeView.transform=CGAffineTransformMakeTranslation(0, 0);
    }];
}
-(void)faalBack:(UIButton*)sender
{
    faalView.alpha=0;
    faalOn=NO;
}
-(void)faalBegir
{
    random=arc4random() %495;
    state=random+1;
    ghazalTextView.text=[verses objectAtIndex:state];
    [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
    showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    homeView.transform=CGAffineTransformMakeTranslation(homeView.frame.size.width, 0);
    BOOL alreadyHas=NO;
    for (NSString* apart in favoriteVerses) {
        if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
            alreadyHas=YES;
            break;
        }
    }
    if (!alreadyHas) {
        [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
    }
    else{
        [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
    }
    ghazalTextView.text=[verses objectAtIndex:state];
    [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];

    [UIView animateWithDuration:0.4 animations:^{
        faalView.transform=CGAffineTransformMakeTranslation(faalView.frame.size.width, 0);
        showView.transform=CGAffineTransformMakeTranslation(0, 0);
    }completion:^(BOOL finished) {
        faalView.alpha=0;
        faalView.transform=CGAffineTransformMakeTranslation(0, 0);

    }];
    faalOn=NO;

}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        if (faalOn) {
            [self faalBegir];
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==pickTextField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)goToNext:(UIButton*)sender
{
    
    if (state < 496){
        state++;
        BOOL alreadyHas=NO;
        for (NSString* apart in favoriteVerses) {
            if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                alreadyHas=YES;
                break;
            }
        }
        if (!alreadyHas) {
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];        }
        else{
        [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
        }

       [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
        ghazalTextView.text=[verses objectAtIndex:state];
    }
    
}
-(void)goToPrevious:(UIButton*)sender
{
    
    if (state > 1 ){
        state--;
        BOOL alreadyHas=NO;
        for (NSString* apart in favoriteVerses) {
            if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                alreadyHas=YES;
                break;
            }
        }
        if (!alreadyHas) {
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
        }
        else{
            [((UIButton*)[horizontalButtons objectAtIndex:2]) setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal ];
        }

        [shomareyeGhazalLabel setTitle:[[NSString stringWithFormat:@"غزل شماره %li",(long)state] convertNumbersToPersian] forState:UIControlStateNormal];
        ghazalTextView.text=[verses objectAtIndex:state];
    }
}

-(void)shakeView {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.05];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(pickTextField.center.x - 5,pickTextField.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(pickTextField.center.x + 5, pickTextField.center.y)]];
    [pickTextField.layer addAnimation:shake forKey:@"position"];
   
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)dismiss123:(UIGestureRecognizer*)sender
{
    pickNumberView.alpha=0;
    [pickNumberView removeGestureRecognizer:tapOnNumbers];
    [pickTextField resignFirstResponder];
    
}

@end
