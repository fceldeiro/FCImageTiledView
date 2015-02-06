//
//  MyCustomView.m
//  FCImageTiledView
//
//  Created by Fabian Celdeiro on 2/5/15.
//  Copyright (c) 2015 Fabián Celdeiro. All rights reserved.
//

#import "MyCustomView.h"


@interface MyCustomView()
@end

@implementation MyCustomView


-(void) initializeViews{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
        self.translatesAutoresizingMaskIntoConstraints = NO;
    
    for (UIView * view in self.subviews){
        [view removeFromSuperview];
    }
    
    NSBundle * mainBundle = nil;
    
#if !TARGET_INTERFACE_BUILDER
    mainBundle = [NSBundle mainBundle];
#else
    mainBundle = [NSBundle bundleForClass:[self class]];
#endif
    
    
    NSArray  *filenames = @[
                            [mainBundle pathForResource:@"icoTc_banelco" ofType:@"png"],
                            [mainBundle pathForResource:@"icoTc_amex" ofType:@"png"],
                            [mainBundle pathForResource:@"icoTc_melicard" ofType:@"png"],
                            [mainBundle pathForResource:@"icoTc_debmaster" ofType:@"png"],
                            [mainBundle pathForResource:@"icoTc_bank_transfer" ofType:@"png"]];

    
    for (int i = 0 ;i<20; i++){
        
        NSString* filenameToUse = nil;
        
        NSInteger filenumber = i%5;
        filenameToUse = filenames[filenumber];
    
        [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filenameToUse]]];
    }
    
}
-(id) initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]){
                self.backgroundColor = [UIColor redColor];
        [self initializeViews];
    }
    
    return self;
}
-(void) awakeFromNib{
    
    
    self.backgroundColor = [UIColor redColor];
    [self initializeViews];
    self.translatesAutoresizingMaskIntoConstraints = NO;

}


-(void) layoutOneLineIntrinsicWidth{
    
    static const CGFloat spacing = 5.0f;
    
    
    UIView * previousImageView = nil;
    for ( int i = 0 ; i<self.subviews.count ; i++){
        
        UIView * currentImage = self.subviews[i];
        
        CGPoint nextPosition = CGPointMake(previousImageView.frame.origin.x + spacing + previousImageView.frame.size.width, spacing);
        
        [currentImage setFrame:CGRectMake(nextPosition.x, nextPosition.y, currentImage.frame.size.width, currentImage.frame.size.height)];
        
        previousImageView = currentImage;
        
    }
    
    [self invalidateIntrinsicContentSize];
    
}

-(void) layoutMultineInstrinsicHeight{
    
    static const CGFloat spacing = 5.0f;
    
    CGFloat maxHeightForRow = spacing;
    CGFloat currentYPosition = spacing;
    
    UIView * previousImageView = nil;
    for ( int i = 0 ; i<self.subviews.count ; i++){
        
        UIView * currentImage = self.subviews[i];
        
        CGPoint nextPosition = CGPointMake(previousImageView.frame.origin.x + spacing + previousImageView.frame.size.width, currentYPosition);
        
        if (currentImage.frame.size.height  > maxHeightForRow){
            maxHeightForRow = currentImage.frame.size.height;

        }
        
        //Me pase
        if (nextPosition.x + currentImage.frame.size.width > self.frame.size.width + spacing ){

            maxHeightForRow = currentImage.frame.size.height;
            currentYPosition = previousImageView.frame.origin.y + maxHeightForRow + spacing;
            nextPosition = CGPointMake(spacing, currentYPosition);
        }
       
        [currentImage setFrame:CGRectMake(nextPosition.x, nextPosition.y, currentImage.frame.size.width, currentImage.frame.size.height)];
    
     previousImageView = currentImage;

    }
    
    self.backgroundColor = [UIColor clearColor];
    
    [self invalidateIntrinsicContentSize];

}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    [self layoutMultineInstrinsicHeight];
   
}


- (CGSize) intrinsicContentSizeMultipleLines{
    
    UIView * lastObject = [self.subviews lastObject];
    // CGFloat width =  lastObject.frame.origin.x + lastObject.frame.size.width + 5;
    CGFloat height = lastObject.frame.origin.y + lastObject.frame.size.height + 5;
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);

}

-(CGSize) intrinsicContentSizeOneLine{
    UIView * lastObject = [self.subviews lastObject];
     CGFloat width =  lastObject.frame.origin.x + lastObject.frame.size.width + 5;
    
    return CGSizeMake(width, UIViewNoIntrinsicMetric);

}
-(CGSize) intrinsicContentSize{
    
    return [self intrinsicContentSizeMultipleLines];
    
}



@end
