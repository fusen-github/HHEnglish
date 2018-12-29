//
//  FSInsertViewController.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSInsertViewController.h"
#import "FSInsertView.h"
#import "FSHanManager.h"
#import "FSPhraseItem.h"


@interface FSInsertViewController ()

@property (nonatomic, weak) FSInsertView *chinese;

@property (nonatomic, weak) FSInsertView *english;

@end

@implementation FSInsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveToDataBase)];
    
    FSInsertView *chinese = [[FSInsertView alloc] init];
    
    self.chinese = chinese;
    
    chinese.title = @"Chinese:";
    
    chinese.placeholder = @"please input Chinese...";
    
    chinese.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:chinese];
    
    
    FSInsertView *english = [[FSInsertView alloc] init];
    
    self.english = english;
    
    english.title = @"English:";
    
    english.placeholder = @"please input English...";
    
    english.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:english];
    
    
    [chinese.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [chinese.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [chinese.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80].active = YES;
    chinese.minHeightLayoutConstraint.active = YES;
    chinese.maxHeightLayoutConstraint.active = YES;
    
    
    [english.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [english.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [english.topAnchor constraintEqualToAnchor:chinese.bottomAnchor constant:20].active = YES;
    english.minHeightLayoutConstraint.active = YES;
    english.maxHeightLayoutConstraint.active = YES;
    
}

- (void)makeTestDatas
{
    NSString *text = @"中共中央总书记国家主席中央军委主席习近平在茶话会上发表重要讲话他强调年是新中国成立周年是决胜全面建成小康社会关键之年我们要崇尚学习加强学习崇尚创新勇于创新崇尚团结增进团结既抢抓发展机遇又妥善应对挑战鼓舞全党全国各族人民勇往直前再创辉煌习近平代表中共中央国务院和中央军委向各民主党派工商联和无党派人士各人民团体向全国广大工人农民知识分子干部和各界人士向人民解放军指战员武警官兵公安干警和消防救援队伍指战员向香港特别行政区同胞澳门特别行政区同胞台湾同胞和海外侨胞向关心和支持中国改革开放和现代化建设的各国朋友致以节日的问候和诚挚的祝福习近平强调年是贯彻落实中共十九大精神开局之年也是党和国家事业发展极不平凡的一年中共中央团结带领全国各族人民按照中共十九大作出的战略部署，推动经济建设政治建设文化建设社会建设生态文明建设以及国防和军队建设港澳工作和对台工作外事工作取得重大进展人民群众获得感幸福感安全感持续增强中国共产党坚持严字当头全面从严一严到底巩固反腐败斗争压倒性胜利继续净化党内政治生态";
    
    /// a-z 97-122
    NSArray *dates = @[@"20181229",@"20181228", @"20181227", @"20181226", @"20181225"];
    
    for (int i = 0; i < 200; i++)
    {
        FSPhraseItem *item = [[FSPhraseItem alloc] init];

        uint32_t random3_8 = arc4random_uniform(5) + 3;
        
        char arr[10];
        
        for (int k = 0; k < random3_8; k++)
        {
            uint32_t letter = arc4random_uniform(26) + 97;
            
            char ch = (char)letter;
            
            arr[k] = ch;
        }
        
        NSString *english = [NSString stringWithUTF8String:arr];
        
        item.english = english;
        
        NSMutableString *chinese = [NSMutableString string];
        
        for (int k = 0; k < random3_8; k++)
        {
            uint32_t tmp = arc4random_uniform((int)text.length);

            NSString *sub = [text substringWithRange:NSMakeRange(tmp, 1)];
            
            [chinese appendString:sub];
        }
        
        item.chinese = chinese;
        
        uint32_t dateIndex = arc4random_uniform((int)dates.count);
        
        item.operateDate = [dates objectAtIndex:dateIndex];
        
        [[FSHanManager shareManager] insertPhraseForDictionary:[item toDictionary]];
    }
}

- (void)saveToDataBase
{
//    [self.view showNetToast:@"正在准备假数据..."];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        [self makeTestDatas];
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//
//            [self.view hideToastAnimate:YES];
//        });
//    });
//    
//    
//    return;
    
    NSString *chinese = self.chinese.text;
    
    if (!chinese.length) {
        
        [self.view showToast:@"中文不能为空"];
        
        return;
    }
    
    NSString *english = self.english.text;
    
    if (!english.length) {
        
        [self.view showToast:@"英文不能为空"];

        return;
    }
    
    FSPhraseItem *item = [[FSPhraseItem alloc] init];
    
    item.chinese = chinese;
    
    item.english = english;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"YYYYMMdd";
    
    item.operateDate = [formatter stringFromDate:[NSDate date]];
    
    BOOL rst = [[FSHanManager shareManager] insertPhraseForDictionary:[item toDictionary]];
    
    if (rst)
    {
        [self.view showToast:@"保存成功!"];
        
        self.chinese.text = nil;
        
        self.english.text = nil;
    }
    else
    {
        [self.view showToast:@"保存失败!"];
    }
    
}


@end
