//
//  TodayViewController.m
//  iBeaconControll
//
//  Created by Massimo on 15/10/23.
//  Copyright © 2015年 Massimo. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TestTableViewCell.h"
#import "UIImageView+WebCache.h"

#define CellHeight 60
static NSInteger imageIdx = 0;

static NSInteger refreshTimes = 0;

@interface TodayViewController () <NCWidgetProviding>
@property (copy, nonatomic) NSArray *names;
@property (copy, nonatomic) NSArray *imageUrls;
@property (copy, nonatomic) NSMutableArray *imageDatas;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

//@property (nonatomic, strong)MyModel *model;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  NSUserDefaults *userDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.IBeaconDemo"];
  [userDefaults objectForKey:@"testKey"];
  _names =@[@"jack",@"kane",@"kittiy",@"green"];
  _imageUrls = @[@[@"http://img.taopic.com/uploads/allimg/130501/240451-13050106450911.jpg",
                   @"http://www.qqpk.cn/Article/UploadFiles/201112/20111206131613418.jpg",
                   @"http://pic1a.nipic.com/2008-12-04/2008124215522671_2.jpg",
                   @"http://pic1.ooopic.com/uploadfilepic/sheji/2009-05-05/OOOPIC_vip4_20090505079ae095187332ea.jpg"],

                 @[@"http://e.hiphotos.baidu.com/image/h%3D360/sign=c9341858b6b7d0a264c9029bfbee760d/b2de9c82d158ccbf0881c1d01dd8bc3eb135411e.jpg",
                   @"http://h.hiphotos.baidu.com/image/h%3D360/sign=35f30673dbf9d72a0864161be42b282a/4ec2d5628535e5ddc8aec79374c6a7efcf1b62ff.jpg",
                   @"http://d.hiphotos.baidu.com/image/h%3D360/sign=de79f1e3d739b60052ce09b1d9513526/f2deb48f8c5494ee3ba8fd192ff5e0fe99257e2c.jpg",
                   @"http://b.hiphotos.baidu.com/image/h%3D360/sign=780e387eb23533faeab6952898d2fdca/9f510fb30f2442a7b8e54cd5d243ad4bd01302d2.jpg"],

                 @[@"http://v1.qzone.cc/avatar/201310/11/12/52/52578422ab27e173.jpg%21200x200.jpg",
                   @"http://v1.qzone.cc/avatar/201308/30/22/56/5220b2828a477072.jpg%21200x200.jpg",
                   @"http://diy.qqjay.com/u2/2014/0210/99c214946a63a078277eee0c71009ab1.jpg",
                   @"http://v1.qzone.cc/avatar/201308/31/12/32/522171d8d638c453.jpg%21200x200.jpg"],

                 @[@"http://p3.qqgexing.com/touxiang/20120822/0721/503417ea05983.jpg",
                   @"http://v1.qzone.cc/avatar/201406/21/12/10/53a5059a01c20862.jpg%21200x200.jpg",
                   @"http://v1.qzone.cc/avatar/201308/17/15/21/520f2495be542462.jpg%21200x200.jpg",
                   @"http://v1.qzone.cc/avatar/201312/22/11/53/52b6624c5090e594.jpg%21200x200.jpg"],
                 ];
  _imageDatas = [NSMutableArray new];

//  [self changeImages:_imageUrls[imageIdx]];

  NSLog(@"userDefaults testKey == %@",[userDefaults valueForKey:@"testKey"]);
  self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, _names.count * CellHeight + 10 + 40 );

//  [self performSelector:@selector(changeText) withObject:nil afterDelay:3.0f];
  __weak typeof(self) weakSelf = self;
  [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
    NSLog(@"NCUpdateResult 刷新");
    refreshTimes++;
    NSString *btnStr = [NSString stringWithFormat:@"点击进入 iBeacon %ld",refreshTimes];
    [weakSelf.myButton setTitle:btnStr forState:UIControlStateNormal];

  }];

}
- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  for (int i = 0 ; i < _names.count; i ++) {
    NSNumber *num = [NSNumber numberWithInt:i ];

    [self performSelector:@selector(refreshCellWithIndex:) withObject:num afterDelay:i * 0.1];

  }
}

- (void)viewDidDisappear:(BOOL)animated{
  [super  viewDidDisappear:animated];
  
}

- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [[SDImageCache sharedImageCache] clearMemory];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return CellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _names.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  TestTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
  cell.textLabel.text = _names[indexPath.row];
  NSString *imageUrl = _imageUrls[imageIdx][indexPath.row];
  NSLog(@"imageUrl  %@",imageUrl);
  [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"welcome.jpg"]];
  
  NSLog(@"cellForRowAtIndexPath %ld %@",indexPath.row,[NSDate date]);

  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  imageIdx++;
  if (imageIdx == _imageUrls.count  ) {
    imageIdx = 0;
  }

  for (int i = 0 ; i < _names.count; i ++) {
    NSNumber *num = [NSNumber numberWithInt:i ];

    [self performSelector:@selector(refreshCellWithIndex:) withObject:num afterDelay:i * 0.1];

  }
  NSLog(@"imageIdx%ld",imageIdx);


}

- (void)refreshCellWithIndex:(NSNumber*)index{

  [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.integerValue inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}




- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
  return UIEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
   NSLog(@"widgetPerformUpdateWithCompletionHandler 刷新");

    completionHandler(NCUpdateResultNewData);
}




- (IBAction)openApp:(UIButton*)sender{
   [self.extensionContext openURL:[NSURL URLWithString:@"iBeacon://finished"] completionHandler:nil];
}
@end
