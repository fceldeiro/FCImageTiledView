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

    
    for (int i = 0 ;i<120; i++){
        
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
    
    static const CGFloat internalSpacingX = 5.0f;
    static const CGFloat internalSpacingY = 5.0f;
    
    CGFloat maxHeightForRow = 0;
    CGFloat currentYPosition = 0;
    
    UIView * previousImageView = nil;
    for ( int i = 0 ; i<self.subviews.count ; i++){
        
        UIView * currentImage = self.subviews[i];
        
        CGFloat currentSpacingX = 0;
        if (i > 0){
            currentSpacingX = internalSpacingX;
        }
        CGPoint nextPosition = CGPointMake(previousImageView.frame.origin.x + currentSpacingX + previousImageView.frame.size.width, currentYPosition);
        
        if (currentImage.frame.size.height  > maxHeightForRow){
            maxHeightForRow = currentImage.frame.size.height;

        }
        
        //Me pase
        if (nextPosition.x + currentImage.frame.size.width > self.frame.size.width ){

            maxHeightForRow = currentImage.frame.size.height;
            currentYPosition = previousImageView.frame.origin.y + maxHeightForRow + internalSpacingY;
            nextPosition = CGPointMake(0, currentYPosition);
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
    
    CGFloat maxX = 0;
    CGFloat maxY = 0;
    for (UIView * view in self.subviews){
        if (view.frame.origin.x + view.frame.size.width > maxX){
            maxX = view.frame.origin.x + view.frame.size.width;
        }
        if (view.frame.origin.y + view.frame.size.height > maxY){
            maxY = view.frame.origin.y + view.frame.size.height;
        }

    }
    return CGSizeMake(maxX, maxY);

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
