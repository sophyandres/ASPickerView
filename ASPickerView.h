//
//  ASPickerView.h
//  SlotMachineTest
//
//  Created by Andrei on 22/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef weak_delegate
#if __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif

@class ASPickerView;

@protocol ASPickerViewDelegate<UIPickerViewDelegate>
- (void)ASPickerView:(ASPickerView *)pickerView didFinishSpiningWithArray:(NSArray*)array;

@end
@interface ASPickerView : UIPickerView

@property (strong) NSMutableArray *RowArray1;
@property (strong) NSMutableArray *RowArray2;
@property (strong) NSMutableArray *RowArray3;
@property (nonatomic,assign) NSInteger row1;
@property (nonatomic,assign) NSInteger row2;
@property (nonatomic,assign) NSInteger row3;
@property (strong) NSTimer *spinTimer;
@property (nonatomic,assign) int numberElements;
@property (nonatomic,assign) int numberOfSecondsToSpin;

@property (nonatomic, weak_delegate) id<ASPickerViewDelegate> delegate;

- (void)Spin;

@end
