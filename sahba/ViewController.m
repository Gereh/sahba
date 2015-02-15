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
    plusIsOn=NO;
    isSearching=NO;
    favoriteOn=NO;
    state=1;
    fontState=15;
    ScreenHeight=self.view.frame.size.height;
    ScreenWidth=self.view.frame.size.width;
    
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
    
    favView=[[UIView alloc]initWithFrame:self.view.frame];
    favImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    favImageView.image=[UIImage imageNamed:@"fav.jpg"];
    [favView addSubview:favImageView];
    [self.view addSubview:favView];
    
    searchView=[[UIView alloc]initWithFrame:self.view.frame];
    searchImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    searchImageView.image=[UIImage imageNamed:@"search.jpg"];
    [searchView addSubview:searchImageView];
    
    searchResult=[[NSMutableArray alloc]init];
    searchTextField=[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/4.5,ScreenHeight/3.5,2*ScreenWidth/3, ScreenHeight/18)];
    
    searchTextField.borderStyle=UITextBorderStyleRoundedRect;
    [searchView addSubview:searchTextField];
    UIButton* searchButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth/9, ScreenHeight/2.8, ScreenWidth/4,ScreenHeight/18)];
    searchButton.layer.cornerRadius=10;
    [searchButton setTitle:@"جست و جو" forState:UIControlStateNormal];
    searchButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchButton.backgroundColor=[UIColor grayColor];
    [searchView addSubview:searchButton];
    UIButton* cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4, ScreenHeight/2.8, ScreenWidth/4,ScreenHeight/18)];
    [cancelButton setTitle:@"لغو" forState:UIControlStateNormal];
    cancelButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius=10;
    cancelButton.backgroundColor=[UIColor grayColor];
    [searchView addSubview:cancelButton];
    searchTable=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/4.5,ScreenHeight/2.3,2*ScreenWidth/3, ScreenHeight/2) style:UITableViewStylePlain];
    searchTable.layer.borderColor=[[UIColor blackColor]CGColor];
    searchTable.layer.borderWidth=2;
    searchTable.delegate=self;
    searchTable.dataSource=self;
    [searchTable setAllowsSelection:YES];
    [searchView addSubview:searchTable];
    
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
    shomareyeGhazalLabel.backgroundColor=[UIColor blueColor];
    //[shomareyeGhazalLabel setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
    [shomareyeGhazalLabel setTitle:[NSString stringWithFormat:@"غزل شماره %li",state] forState:UIControlStateNormal];
    [showView addSubview:shomareyeGhazalLabel];
    
    ghazalTextView=[[UITextView alloc]initWithFrame:CGRectMake(showView.frame.size.width/6, showView.frame.size.height/4.5, 2*showView.frame.size.width/3, showView.frame.size.height-(showView.frame.size.height/2.8))];
    ghazalTextView.text=[verses objectAtIndex:state];
    ghazalTextView.font=[UIFont fontWithName:@"Arial" size:fontState];
    ghazalTextView.editable=NO;
    ghazalTextView.textAlignment=NSTextAlignmentCenter;
    [showView addSubview:ghazalTextView];
    NSArray* showPageButtons=[[NSArray alloc]initWithObjects:@"home",@"number",@"fav",@"search",@"plus", nil];
    horizontalButtons=[[NSMutableArray alloc]init];
    for (int i=0; i<[showPageButtons count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*ScreenWidth/6 +ScreenWidth/10.5, ScreenHeight/1.12, ScreenWidth/6.5, ScreenWidth/6.5)];
        [button setTitle:[showPageButtons objectAtIndex:i] forState:UIControlStateNormal];
        //[button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        button.layer.cornerRadius= ScreenWidth/13;
        button.backgroundColor=[UIColor blueColor];
        button.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
        [showView addSubview:button];
        [button addTarget:self action:@selector(horizontalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [horizontalButtons addObject:button];
    }
    
    pickNumberView=[[UIView alloc]initWithFrame:showView.frame];
    pickNumberView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    UIView* pick=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, ScreenHeight/5)];
    pick.backgroundColor=[UIColor whiteColor];
    pick.layer.cornerRadius=10;
    pick.layer.borderWidth=2;
    pick.layer.borderColor=[[UIColor blackColor]CGColor];
    
    pickTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth/2-20, ScreenHeight/20)];
    pickTextField.borderStyle=UITextBorderStyleRoundedRect;
    pickTextField.placeholder=@"شماره غزل را وارد کنید...";
    pickTextField.font=[UIFont fontWithName:@"Arial" size:12];
    pickTextField.textAlignment=NSTextAlignmentCenter;
    pickTextField.delegate=self;
    [pick addSubview:pickTextField];
    pick.center=CGPointMake(ScreenWidth/2, ScreenHeight/3);
    [pickNumberView addSubview:pick];
    
    UIButton* goButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/5, ScreenHeight/20)];
    goButton.backgroundColor=[UIColor blackColor];
    goButton.center=CGPointMake(pick.frame.size.width/2, pick.frame.size.height/2+10);
    [goButton setTitle:@"برو" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goButton.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    goButton.layer.cornerRadius=10;
    [goButton addTarget:self action:@selector(goToVerse) forControlEvents:UIControlEventTouchUpInside];
    
    [pick addSubview:goButton];
    [showView addSubview:pickNumberView];
    pickNumberView.alpha=0;
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
        
        [button setBackgroundImage:[UIImage imageNamed:@"menu-key-back.jpg"] forState:UIControlStateNormal];
        [button setTitle:[buttonsTitle objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [homeView addSubview:button];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    plusView=[[UIView alloc]initWithFrame:self.view.frame];
    plusView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
    NSArray* ButtonsOnPlus=[[NSArray alloc]initWithObjects:@"T+",@"T-",@"share", nil];
    verticalButtons=[[NSMutableArray alloc]init];
    for (int i=0; i<[ButtonsOnPlus count]; i++) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/1.3, ScreenHeight/1.3 -(i*ScreenHeight/9), ScreenWidth/7, ScreenWidth/7)];
        [button setTitle:[ButtonsOnPlus objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.cornerRadius=ScreenWidth/14;
        button.backgroundColor=[UIColor redColor];
        [plusView addSubview:button];
        button.alpha=0;
        [verticalButtons addObject:button];
        [button addTarget:self action:@selector(verticalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [showView addSubview:plusView];
    [showView bringSubviewToFront:[horizontalButtons objectAtIndex:4]];
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnPlusView)];
    [plusView addGestureRecognizer:tap];
    plusView.alpha=0;
    if ([favoriteVerses containsObject:@"1"]) {
        ((UIButton*)[horizontalButtons objectAtIndex:2]).backgroundColor=[UIColor yellowColor];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
-(void)goToVerse{
    if (![pickTextField.text isEqualToString: @""]) {
        state=[pickTextField.text integerValue];
        BOOL alreadyHas=NO;
        for (NSString* apart in favoriteVerses) {
            if ([[NSString stringWithFormat:@"%li",(long)(state)] isEqualToString: apart]) {
                alreadyHas=YES;
                break;
            }
        }
        if (!alreadyHas) {
            ((UIButton*)[horizontalButtons objectAtIndex:2]).backgroundColor=[UIColor blueColor];
        }
        else{
            ((UIButton*)[horizontalButtons objectAtIndex:2]).backgroundColor=[UIColor yellowColor];
        }
        ghazalTextView.text=[verses objectAtIndex:state];
        [shomareyeGhazalLabel setTitle:[NSString stringWithFormat:@"غزل شماره %li",state] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        pickNumberView.alpha=0;
    }];
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    select=indexPath.row;
    if (tableView==searchTable) {
        
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
        //    if (favoriteOn) {
        if (favoriteVerses.count> indexPath.row) {
            select=((NSString*)[favoriteVerses objectAtIndex: indexPath.row]).integerValue;
        }
        else
            return cell;
        NSArray* versComp=[(NSString*)[verses objectAtIndex:select] componentsSeparatedByString:@"\n"];
        cell.textLabel.text=[versComp objectAtIndex:2];
        //}
    }
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.textLabel.font=[UIFont fontWithName:@"Arial" size:15];
    return cell;
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
    [UIView animateWithDuration:0.5 animations:^{
        homeView.transform=CGAffineTransformMakeTranslation(0, 0);
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    }];
}
-(void)searchButtonClicked
{
    [UIView animateWithDuration:0.5 animations:^{
        searchView.transform=CGAffineTransformMakeTranslation(0, 0);
        showView.transform=CGAffineTransformMakeTranslation(-showView.frame.size.width, 0);
    }];

}
-(void)numberButtonClicked
{
    [UIView animateWithDuration:0.1 animations:^{
        pickNumberView.alpha=1;
    }];
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
        sender.backgroundColor=[UIColor yellowColor];
        // [sender setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    }
    else{
        [favoriteVerses removeObject:[NSString stringWithFormat:@"%li",(long)state]];
        sender.backgroundColor=[UIColor blueColor];
        //[sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [favoriteVerses writeToFile:fileAddress atomically:YES];
}
-(void)plusButtonClicked
{
    if (!plusIsOn) {
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
-(void)verticalButtonClicked:(UIButton*)sender
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
    if (fontState < 18) {
        fontState++;
        ghazalTextView.font=[UIFont fontWithName:@"Arial" size:fontState];

    }
}
-(void)fontMinusAction{
    
    if (fontState > 10) {
        fontState--;
        ghazalTextView.font=[UIFont fontWithName:@"Arial" size:fontState];
    }
}
-(void)share:(UIButton*)sender
{
    NSString *textToShare=ghazalTextView.text;
    NSURL *myWebsite = [NSURL URLWithString:@""];
    
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
@end
