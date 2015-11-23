//
//  ASPickerView.m
//  SlotMachineTest
//
//  Created by Andrei on 22/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import "ASPickerView.h"

@interface ASPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@end
@implementation ASPickerView

@synthesize delegate = _delegate;

- (void)baseInit {
    //initialise row arrays of objects
    _RowArray1 = [NSMutableArray arrayWithObjects:@"slotimage1.jpg",@"slotimage2.jpg",@"slotimage3.jpg", nil];
    _RowArray2 = [NSMutableArray arrayWithObjects:@"slotimage3.jpg",@"slotimage1.jpg",@"slotimage2.jpg", nil];
    _RowArray3 = [NSMutableArray arrayWithObjects:@"slotimage2.jpg",@"slotimage3.jpg",@"slotimage1.jpg", nil];
    //define default elements to spin
    _numberElements = 0;
    _numberOfSecondsToSpin = 1; //default amount to spin the slots - 1 second
    self.translatesAutoresizingMaskIntoConstraints = YES;
    //set delegates
    _delegate = nil;
    super.dataSource = self;
    super.delegate = self;
    //detect if timer active and invalidate it if true
    if(_spinTimer){
        [_spinTimer invalidate];
    }
    
    [self refresh];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)setDataSource:(__unused id<UIPickerViewDataSource>)dataSource
{
    //does nothing
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
    
}

-(void)Spin{

        [self reloadAllComponents];
    
        _spinTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 //this value arranges the speed of the autoScroll
                                                      target:self
                                                    selector:@selector(automaticScroll)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:_numberOfSecondsToSpin //this arranges the duration of the scroll
                                         target:self
                                       selector:@selector(stopscroll)
                                       userInfo:nil
                                        repeats:NO];
    
    
}

-(void)automaticScroll
{
    //scrolls all the components
    NSUInteger randomIndexSpin1 = 0;
    NSUInteger randomIndexSpin2 = 0;
    NSUInteger randomIndexSpin3 = 0;
    
    randomIndexSpin1 = arc4random() % _numberElements;
    randomIndexSpin2 = arc4random() % _numberElements;
    randomIndexSpin3 = arc4random() % _numberElements;
    
    [self selectRow:randomIndexSpin1 inComponent:0 animated:YES];
    [self selectRow:randomIndexSpin2 inComponent:1 animated:YES];
    [self selectRow:randomIndexSpin3 inComponent:2 animated:YES];
}

-(void)stopscroll
{
    //stop tabletimer again
    [_spinTimer invalidate];
    [self performSelector:@selector(resultsOfSpin) withObject:nil afterDelay:1.2];
}

-(void)resultsOfSpin{
    
    _row1 = [self selectedRowInComponent:0];
    _row2 = [self selectedRowInComponent:1];
    _row3 = [self selectedRowInComponent:2];
    
    NSString *ImageNameForRow1 = [_RowArray1 objectAtIndex:_row1];
    NSString *ImageNameForRow2 = [_RowArray2 objectAtIndex:_row2];
    NSString *ImageNameForRow3 = [_RowArray3 objectAtIndex:_row3];
   
 __strong id<ASPickerViewDelegate> strongDelegate = _delegate;
    NSArray *ResultsArray = [NSArray arrayWithObjects:ImageNameForRow1,ImageNameForRow2,ImageNameForRow3, nil];
    [strongDelegate ASPickerView:self didFinishSpiningWithArray:ResultsArray];
}

- (void)setNumberElements:(int)numberElements {
    // set the number of elements per component
    _numberElements = numberElements;
    [self AddElementsRandomlyForArray:_RowArray1 andArray:1];
    [self AddElementsRandomlyForArray:_RowArray2 andArray:2];
    [self AddElementsRandomlyForArray:_RowArray3 andArray:3];
   
}
-(void)setNumberOfSecondsToSpin:(int)numberOfSecondsToSpin{
    _numberOfSecondsToSpin = numberOfSecondsToSpin;
    [self refresh];
}

-(void)refresh{
   
    [self reloadAllComponents];
    [self selectRow:1 inComponent:0 animated:YES];
    [self selectRow:1 inComponent:1 animated:YES];
    [self selectRow:1 inComponent:2 animated:YES];
}

-(void)AddElementsRandomlyForArray:(NSMutableArray*)Array andArray:(int)ArrayNumber{
  //Add elements per array
    NSArray *SampleArray = [NSArray arrayWithObjects:@"slotimage1.jpg",@"slotimage2.jpg",@"slotimage3.jpg", nil];
    Array = [[NSMutableArray alloc]init];
    for(int i=0; i<_numberElements; i++){
        NSUInteger randomIndex = arc4random() % [SampleArray count];
        NSString *imageName = [SampleArray objectAtIndex:randomIndex];
        if([Array count]>0){
            if([[Array lastObject]isEqualToString:imageName]){
                
                
                for(NSString *OtherImage in SampleArray) {
                    if(![OtherImage isEqualToString:imageName]){
                        [Array addObject:OtherImage];
                        break;
                    }
                }
                
                
            }else{
                [Array addObject:imageName];
            }
            
            
        }else{
            [Array addObject:imageName];
        }
        
        if(i==_numberElements-1){
            if(ArrayNumber==1){
                _RowArray1 = Array;
            }else if(ArrayNumber==2){
                _RowArray2 = Array;
            }else{
                _RowArray3 = Array;
            }
            //reload the pickerview
            [self reloadAllComponents];
        }
        
    }
}
//delegate methods for UIPickerView

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImageView* icon = nil;
    if (view == nil) {
        view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width/3, pickerView.frame.size.height/3)];
        if(component==0){
            
            icon.image = [UIImage imageNamed:[_RowArray1 objectAtIndex:row]];
        }else if(component==1){
            icon.image = [UIImage imageNamed:[_RowArray2 objectAtIndex:row]];
        }else{
            icon.image = [UIImage imageNamed:[_RowArray3 objectAtIndex:row]];
        }
        icon.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:icon];
    }
    if (icon == nil) {
        
        icon = view.subviews[0]; // I do get subviews here.
    }
    return view;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return pickerView.frame.size.height/3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSUInteger intcount;
    if(component == 0){
        intcount = [_RowArray1 count];
    }
    else  if(component== 1){
        intcount = [_RowArray2 count];
    }
    else {
        intcount = [_RowArray3 count];
    }
    return intcount;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

@end
