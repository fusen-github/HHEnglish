//
//  FSHomeViewController.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSHomeViewController.h"
#import "FSInsertViewController.h"
#import "FSHanManager.h"
#import "FSPhraseItem.h"


@interface FSHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"过滤" style:UIBarButtonItemStylePlain target:self action:@selector(showSetting)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(wantToInsertDatas)];
    
    [self loadDatas];
    
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

- (void)showSetting
{
    
}

- (void)wantToInsertDatas
{
    FSInsertViewController *insert = [[FSInsertViewController alloc] init];
    
    [self.navigationController pushViewController:insert animated:YES];
}

- (void)loadDatas
{
    [self.view showToast:@"查询数据..."];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *array =  [[FSHanManager shareManager] queryPhrases];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array)
        {
            FSPhraseItem *item = [FSPhraseItem itemWithDict:dict];
            
            [tmpArray addObject:item];
        }
        
        self.dataArray = tmpArray;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
            
            [self.view hideToastAnimate:YES];
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kCellId = NSStringFromClass([self class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    FSPhraseItem *item = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.english;
    
    return cell;
}

@end
