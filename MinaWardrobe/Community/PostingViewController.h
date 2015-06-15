//
//  PostingViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostingTextTableViewCell.h"

#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "GDataXMLNode.h"

@interface PostingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ELCImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate, NSXMLParserDelegate, ASIHTTPRequestDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tView;

@property (nonatomic, strong) UIButton *listButton;
@property (nonatomic, strong) UIView *classButtonView;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) UIButton *classButton;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSString *valueStr;

@property (nonatomic, strong) UIView *imageArrView;
@property (nonatomic, strong) NSMutableArray *imaArray;
@property (nonatomic, strong) UIImageView *imaView;

@property (nonatomic, strong) UIImageView *ima1;
@property (nonatomic, strong) UIImageView *ima2;
@property (nonatomic, strong) UIImageView *ima3;
@property (nonatomic, strong) UIButton *dBtn1;
@property (nonatomic, strong) UIButton *dBtn2;
@property (nonatomic, strong) UIButton *dBtn3;


@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *deleteBtn;



@property (nonatomic, strong) NSString *xmlStr;

//解析出得数据，内部是字典类型
@property (strong,nonatomic) NSMutableArray *notes;

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString *currentTagName;

@property (nonatomic, strong) NSData *xmlData;

//开始解析
- (void)start;

@end
