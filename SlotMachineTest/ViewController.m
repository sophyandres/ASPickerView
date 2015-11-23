//
//  ViewController.m
//  SlotMachineTest
//
//  Created by Andrei on 20/11/2015.
//  Copyright © 2015 Andrei. All rights reserved.
//

#import "ViewController.h"
#import "ASPickerView.h"
#import <QuartzCore/QuartzCore.h>
#define NUMBER_ELEMENTS 200

@interface ViewController ()<ASPickerViewDelegate>{
   
}
@property (strong, nonatomic) UIImageView *BackgroundImage;
@property (weak, nonatomic) IBOutlet ASPickerView *SlotPickerView;
@property (weak, nonatomic) IBOutlet UIButton *SpinButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetupView];
    //Add the slots
    self.SlotPickerView.numberElements = NUMBER_ELEMENTS;
    self.SlotPickerView.numberOfSecondsToSpin = 2;
    self.SlotPickerView.delegate = self;
   
}
-(void)SetupView{
    //Add background
    _BackgroundImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    _BackgroundImage.image = [UIImage imageNamed:@"17896682-Illustration-of-a-letter-box-and-flower-pot-in-a-garden-Stock-Vector.jpg"];
    _BackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:_BackgroundImage belowSubview:_SpinButton];
    //rounded corners for Spin Button
    _SpinButton.layer.cornerRadius = 5;
    _SpinButton.layer.masksToBounds = YES;
}

- (IBAction)Spin:(id)sender {

    [self.SlotPickerView Spin];
  
}

//ASPickerView delegate
- (void)ASPickerView:(ASPickerView *)pickerView didFinishSpiningWithArray:(NSArray*)array{

    int occurrences = 0;
    NSString *stringToCompare = [array objectAtIndex:0];
    for(NSString *string in array){
        occurrences += ([string isEqualToString:stringToCompare]?1:0);
    }
    int occurrences1 = 0;
    NSString *stringToCompare1 = [array objectAtIndex:1];
    for(NSString *string1 in array){
        occurrences1 += ([string1 isEqualToString:stringToCompare1]?1:0);
    }
    int occurrences2 = 0;
    NSString *stringToCompare2 = [array objectAtIndex:2];
    for(NSString *string2 in array){
        occurrences2 += ([string2 isEqualToString:stringToCompare2]?1:0);
    }
    
    

    if(occurrences>2||occurrences1>2||occurrences2>2){
    [self ShowAlertWithTitle:@"Success" andMessage:@"You won!"];

    }else{
    [self ShowAlertWithTitle:@"Failed" andMessage:@"You lost. Try again!"];
    }
}
-(void)ShowAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel your yes please button action here
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)ASPickerView:(ASPickerView *)pickerView didGenerateNumbersForRows:(NSArray*)array;{
        NSLog(@"array %@ %@ %@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
