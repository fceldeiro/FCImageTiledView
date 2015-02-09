//
//  MyCustomView.h
//  FCImageTiledView
//
//  Created by Fabian Celdeiro on 2/5/15.
//  Copyright (c) 2015 Fabián Celdeiro. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MyCustomView : UIView

@property (nonatomic) IBInspectable CGFloat spacingX;

-(void) setImages:(NSArray*) images animated:(BOOL) animated;
@end
