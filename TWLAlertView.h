//
//  TWLAlertView.h
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.


#import <UIKit/UIKit.h>
@protocol TWlALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password;
- (void)successPassword;
- (void)skiptoRulervc;

@end
@interface TWLAlertView : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * title;
@property (nonatomic,strong)NSArray *contentArr;
@property (nonatomic,strong)UILabel *tipLable;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
@property (nonatomic,assign)NSInteger type;//类型
@property (nonatomic,assign)NSInteger numBtn;//按钮个数
@property (nonatomic,copy)NSString *password;//返回string
@property (nonatomic,retain)NSArray *btnTitleArr;//按钮文字
@property (nonatomic,retain)UITextField *textF;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,copy)NSString *selecteName;
@property (nonatomic,retain)UIButton *selectedBtn;
@property (nonatomic,assign)NSInteger defaultRow;//默认
@property (nonatomic,strong)NSMutableArray *selectBtnArray;
- (instancetype)initWithframe:(CGRect)frame Title:(NSString *) title contentArr:(NSArray *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr;
- (void)cancleView;
- (void)showAlerView;
@end

