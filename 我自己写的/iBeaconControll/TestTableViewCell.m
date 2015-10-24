//
//  TestTableViewCell.m
//  iBeaconDemo
//
//  Created by Massimo on 15/10/24.
//  Copyright © 2015年 Massimo. All rights reserved.
//

#import "TestTableViewCell.h"
@interface TestTableViewCell()
@property (copy, nonatomic)NSURL *url;
@end
@implementation TestTableViewCell


- (void)layoutSubviews{
  [super layoutSubviews];
  CGFloat imageX = self.imageView.frame.origin.x;
  CGFloat imageY = self.imageView.frame.origin.y;
  self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 40, 40);
  self.imageView.center = CGPointMake(self.imageView.center.x, self.bounds.size.height/2);
  self.textLabel.frame = CGRectMake(imageX + self.imageView.frame.size.width + 8, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
  self.imageView.layer.cornerRadius = CGRectGetHeight(self.imageView.frame)/2;
  self.imageView.layer.masksToBounds = YES;
  

}
- (void)awakeFromNib {
    // Initialization code
}
- (void)imageUrl:(NSString*)imageUrl{
  if (_url) {
    return;
  }
   _url = [NSURL URLWithString:imageUrl];
  __weak typeof(self) weakSelf = self;
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSURL *url = weakSelf.url;

    NSData *data = [NSData dataWithContentsOfURL:url];

    dispatch_async(dispatch_get_main_queue(), ^{

      [self.imageView setImage:[UIImage imageWithData:data]];

    });
  });
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
