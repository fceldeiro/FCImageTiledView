//
//  MyCustomView.m
//  FCImageTiledView
//
//  Created by Fabian Celdeiro on 2/5/15.
//  Copyright (c) 2015 Fabián Celdeiro. All rights reserved.
//

#import "MyCustomView.h"


@interface MyCustomView()
@property (nonatomic,strong) NSArray  * images;
@end

@implementation MyCustomView


-(id) initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]){
                self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}
-(void) awakeFromNib{
    
    
    NSLog(@"Im awake");
    self.backgroundColor = [UIColor redColor];
}


-(void) prepareForInterfaceBuilder{
    
  
    
}
-(void) layoutSubviews{
    [super layoutSubviews];
    
    
    static const CGFloat spacing = 5.0f;
    
    
    NSBundle * mainBundle = nil;
    
#if !TARGET_INTERFACE_BUILDER
    mainBundle = [NSBundle mainBundle];
#else
    mainBundle = [NSBundle bundleForClass:[self class]];
#endif
    
    NSMutableArray * manyImages = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0 ;i<10; i++){
        
        NSString * filenameA = [mainBundle pathForResource:@"icoTc_banelco" ofType:@"png"];
        NSString * filenameB = [mainBundle pathForResource:@"icoTc_amex" ofType:@"png"];

        
        if (i%2){
            [manyImages addObject:[UIImage imageWithContentsOfFile:filenameA]];
        }
        else{
            [manyImages addObject:[UIImage imageWithContentsOfFile:filenameB]];
        }
    }
    self.images = [NSArray arrayWithArray:manyImages];
    
    UIImageView * previousImageView = nil;
    for ( int i = 0 ; i<self.images.count ; i++){
        
        UIImageView * newImageView = [[UIImageView alloc]initWithImage:self.images[i]];
        [newImageView setFrame:CGRectMake(spacing, spacing, newImageView.frame.size.width, newImageView.frame.size.height)];
        
      
        if (previousImageView){
            [newImageView setFrame:CGRectMake(previousImageView.frame.origin.x + spacing + previousImageView.frame.size.width, previousImageView.frame.origin.y, newImageView.frame.size.width, newImageView.frame.size.height)];
        }
        previousImageView = newImageView;
        [self addSubview:newImageView];
    }
    
    self.backgroundColor = [UIColor clearColor];
//    self.layer.backgroundColor = [UIColor redColor].CGColor;
    
  
}

-(CGSize) intrinsicContentSize{
    

    UIView * lastObject = [self.subviews lastObject];
    CGFloat width =  lastObject.frame.origin.x + lastObject.frame.size.width + 5;
    CGFloat height = lastObject.frame.origin.y + lastObject.frame.size.height + 5;
    
    return CGSizeMake(width, height);
    
//    CGSize sizeToReturn = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return sizeToReturn;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//    self.layer.backgroundColor = [UIColor redColor].CGColor;
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(ctx, rect);
//    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
//    CGContextFillPath(ctx);
//
//}


@end
