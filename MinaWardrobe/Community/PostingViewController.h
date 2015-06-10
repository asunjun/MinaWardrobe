//
//  PostingViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostingTextTableViewCell.h"
#import "PostingMapTableViewCell.h"

#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface PostingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ELCImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *naviView;

@property (strong, nonatomic) IBOutlet UITableView *tView;

@property (nonatomic, strong) UIButton *listButton;
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, assign) BOOL show;

@property (nonatomic, strong) NSMutableArray *imaArray;

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *addButton;




@property (nonatomic, strong) UITextView *testView;
@property (nonatomic, strong) NSString *testStr;

@end
