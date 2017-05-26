//
//  UIAlertController+WKBlockAndAutoDismiss.h
//  LittleElephantQualityLearning
//
//  Created by 吴珂 on 2017/5/25.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WKPopoverPresentationControllerBlock)(UIPopoverPresentationController *popPresenter);

@interface UIAlertController (WKBlockAndAutoDismiss)

+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
               preferredStyle:(UIAlertControllerStyle)preferredStyle
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
popoverPresentationControllerBlock:(WKPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                       action:(void(^)(NSInteger index))tapAction
            otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION;


#pragma mark - Convenience Method
+ (instancetype)showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       action:(void(^)(NSInteger index))tapAction
            otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION;


/**
 ipad 的话必须要设置 popoverPresentationControllerBlock
*/
+ (instancetype)showActionSheetWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
popoverPresentationControllerBlock:(WKPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                            action:(void(^)(NSInteger index))tapAction
                 otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION;

#pragma mark - AutoDismiss

/**
 自动消失的alert

 @param title title
 @param message message
 @return alert view controller
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message;
@end
