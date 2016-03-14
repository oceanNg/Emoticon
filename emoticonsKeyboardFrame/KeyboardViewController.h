//
//  KeyboardViewController.h
//  emoticonsKeyboardFrame
//
//  Created by admin on 3/13/16.
//  Copyright © 2016 carpediem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIInputViewController<UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UIButton *backBtn;
    
    __weak IBOutlet UIButton *nextBtn;
    __weak IBOutlet UIScrollView *scrollview;
    __weak IBOutlet UIButton *globeBtn;
    __weak IBOutlet UIButton *helpBtn;
    __weak IBOutlet UIButton *shareBtn;
    
    __weak IBOutlet UIButton *backSpaceBtn;
    
#pragma mark  -- view help --
    
    __weak IBOutlet UIView *helpView;
    __weak IBOutlet UILabel *helpContentLabel;
    __weak IBOutlet UIImageView *globeImage;
    __weak IBOutlet UIButton *helpNextContentBtn;
    
#pragma  mark -- collection view image --
    
     
     UIView *viewGifs;
     UIView *viewSticker;
    NSMutableArray * stickersDatalist, * gifsDatalist;
    BOOL isShowsTickers;
    
}


@end
