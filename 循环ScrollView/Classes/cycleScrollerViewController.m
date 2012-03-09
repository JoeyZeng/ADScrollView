//
//  cycleScrollerViewController.m
//  cycleScroller
//
//  Created by KISSEI COMTEC on 11/08/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cycleScrollerViewController.h"

@implementation cycleScrollerViewController
@synthesize scView;
@synthesize pageCon;



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setCurrentPageNumber:(int)pageNum
{
    if (pageNum == totalPages_) {
        pageNum = 0;
    } else if (pageNum == -1){
        pageNum = totalPages_ - 1;
    }
    self.pageCon.currentPage = pageNum;
}

- (void)automaticChange{

    [self.scView setContentOffset:CGPointMake(self.scView.contentOffset.x+320, 0) animated:YES];
    [self setCurrentPageNumber:self.pageCon.currentPage+1];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    images = [[NSMutableArray alloc] initWithCapacity:0];

	currentPage_ = 0;
	totalPages_ = 6;
    
    curX = 0;
    
	//将所有图片放入imageview后存入数组
	for (int i = 0; i < totalPages_; i++) {
		UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", i]];
		[images addObject:img];
	}
    
    for (int i = 0; i < totalPages_; i++) {
		UIImageView *imgView = [[UIImageView alloc] initWithImage:[images objectAtIndex:i]];
        imgView.frame = CGRectMake(i*320, 0, 320, 460);
        [self.scView addSubview:imgView];
        [imgView release];
	}

    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[images objectAtIndex:5]];
    imgView.frame = CGRectMake(-320, 0, 320, 460);
    [self.scView addSubview:imgView];
    [imgView release];
    
    imgView = [[UIImageView alloc] initWithImage:[images objectAtIndex:0]];
    imgView.frame = CGRectMake(totalPages_*320, 0, 320, 460);
    [self.scView addSubview:imgView];
    [imgView release];

	self.pageCon.numberOfPages = totalPages_;
	self.pageCon.currentPage = 0;
    
    self.scView.contentSize = CGSizeMake(320*(totalPages_+2), 460);
    self.scView.contentInset = UIEdgeInsetsMake(0, 320, 0, 0);
    self.scView.delegate = self;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(automaticChange) userInfo:nil repeats:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark scroll view delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int page = floor((scrollView.contentOffset.x - 320 / 2) / 320) + 1;
    if ([timer isValid] && page == totalPages_) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(automaticChange) userInfo:nil repeats:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = floor((scrollView.contentOffset.x - 320 / 2) / 320) + 1;
    [self setCurrentPageNumber:page];
    
    if (page == -1) {
        [scrollView setContentOffset:CGPointMake((totalPages_-1)*320, 0) animated:NO];
    } else if (page == totalPages_) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

@end
