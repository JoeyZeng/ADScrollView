//
//  cycleScrollerViewController.h
//  cycleScroller
//
//  Created by KISSEI COMTEC on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cycleScrollerViewController : UIViewController<UIScrollViewDelegate> {
	UIScrollView *scView;
	UIPageControl *pageCon;
	
    NSMutableArray *images;
	
	int currentPage_; //当前页
	int totalPages_; //总图片数量
    
    float curX;
    BOOL isMoving;
    
    NSTimer *timer;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageCon;

@end

