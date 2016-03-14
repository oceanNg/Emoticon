//
//  KeyboardViewController.m
//  emoticonsKeyboardFrame
//
//  Created by admin on 3/13/16.
//  Copyright © 2016 carpediem. All rights reserved.
//

#import "KeyboardViewController.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface KeyboardViewController ()

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isShowsTickers = YES;
    [self setupViewChangeWhileShowSticker];
    [self loadGifsData];
    [self loadStickersData];
    
    [self setupScrollView];
    
    
    
    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void) setupViewChangeWhileShowSticker
{
    [backBtn setHidden:!isShowsTickers];
    [nextBtn setHidden:isShowsTickers];
    titleLabel.text = isShowsTickers ? @"GIFS" : @"STICKERS";
    
 }

#pragma  mark -- load data list --
-(void)loadStickersData
{
    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"sticker"];
    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    for (NSString* path in PhotoArray) {
        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    }
    stickersDatalist =[@[]mutableCopy];
    stickersDatalist = imgQueue;
    
}
-  (void) loadGifsData
{
    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"gif"];
    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    for (NSString* path in PhotoArray) {
        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    }
    gifsDatalist =[@[]mutableCopy];
    gifsDatalist = imgQueue;

}

#pragma  mark == setup ScrollView ==

- (void) setupScrollView
{
    scrollview.contentSize = CGSizeMake(screenWidth  * 2, scrollview.frame.size.height);
    scrollview.tag = 10;
    viewSticker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, scrollview.frame.size.height-1)];
    viewSticker.backgroundColor =[UIColor redColor];
    
    viewGifs =[[UIView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, scrollview.frame.size.height-1)];
    viewGifs.backgroundColor =[UIColor blueColor];
    [scrollview addSubview:viewSticker];
    [scrollview addSubview:viewGifs];
    scrollview.alwaysBounceVertical= NO;
    scrollview.scrollsToTop = NO;
    
    

}
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (_scrollView.tag == 10) {
        CGFloat pageWidth = screenWidth;
        float fractionalPage = _scrollView.contentOffset.x / pageWidth;
        NSInteger pageScrollView= lround(fractionalPage);
        isShowsTickers = pageScrollView =0 ? YES : NO;
        [self setupViewChangeWhileShowSticker];
        
        
    }
}

#pragma  mark == collection view ==

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return isShowsTickers ? stickersDatalist.count : gifsDatalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *  cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"collectionView" owner:nil options:nil][0];
    }
    
    UIImageView * imageView = (UIImageView *)  [cell viewWithTag:101];
    imageView.image = isShowsTickers ? [stickersDatalist objectAtIndex: indexPath.row] : [gifsDatalist objectAtIndex:indexPath.row];
    
    
    return  cell;
    
}
#pragma  mark == text input change ==

- (void)textWillChange:(id<UITextInput>)textInput
{
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
//    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}



#pragma  mark == Action Method ==
- (IBAction)didpressBackBtn:(id)sender
{
    isShowsTickers = YES;
    [scrollview setContentOffset:CGPointMake(0, 0)];
    [self setupViewChangeWhileShowSticker];

}
- (IBAction)didPressNext:(id)sender {
    isShowsTickers = NO;
    [scrollview setContentOffset:CGPointMake(screenWidth, 0)];
    [self setupViewChangeWhileShowSticker];
}
- (IBAction)didPressBackSpaceBtn:(id)sender
{
    [self.textDocumentProxy deleteBackward];
}
- (IBAction)didPressShareBtn:(id)sender {
    
    [self.textDocumentProxy insertText:@"Hello world"];

}

- (IBAction)didPressHelpBtn:(id)sender
{
    [helpView setHidden:NO];
    
}

- (IBAction)didPressGlobebtn:(id)sender
{
    //required functionality, switches to user's next keyboard
    [self advanceToNextInputMode];
}

#pragma  mark -- help Content view --
- (IBAction)didPresshelpContentBtn:(id)sender {
}


@end
