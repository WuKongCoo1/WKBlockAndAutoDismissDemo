//
//  UIAlertController+WKBlockAndAutoDismiss.m
//  LittleElephantQualityLearning
//  传递可变参数 https://stackoverflow.com/questions/2391780/how-to-pass-variable-arguments-to-another-method
//  Created by 吴珂 on 2017/5/25.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import "UIAlertController+WKBlockAndAutoDismiss.h"

#define SafeCallTapAction(callAction, idx)\
if(callAction){\
tapAction(idx);\
NSLog(@"点击了%li", idx);\
}\

const CGFloat WKAutoDismissTimeInterval = 1.f;


@implementation UIAlertController (WKBlockAndAutoDismiss)


+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
               preferredStyle:(UIAlertControllerStyle)preferredStyle
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
popoverPresentationControllerBlock:(WKPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                       action:(void(^)(NSInteger index))tapAction
                   firstTitle:(NSString *)firstTitle
                       valist:(va_list)args
                  autoDismiss:(BOOL)autoDismiss
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    NSString *other = nil;
    NSMutableArray *otherTitles = [NSMutableArray array];
    if(firstTitle){
        [otherTitles addObject:firstTitle];
        
        while((other = va_arg(args, NSString*))){
            [otherTitles addObject:other];
        }
        
    }
    
    [otherTitles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SafeCallTapAction(tapAction, idx);
        }];
        [alert addAction:otherAction];
    }];
    
    if(destructiveButtonTitle){
        
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [alert.actions indexOfObject:action];
            SafeCallTapAction(tapAction, index);
        }];
        [alert addAction:destructiveAction];
    }
    
    if(cancelButtonTitle){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel");
            NSInteger index = [alert.actions indexOfObject:action];
            SafeCallTapAction(tapAction, index)
        }];
        [alert addAction:cancelAction];
    }
    
    if(preferredStyle == UIAlertControllerStyleActionSheet && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        NSParameterAssert(popoverPresentationControllerBlock);
        UIPopoverPresentationController *popPresenter = [alert
                                                         popoverPresentationController];
        popoverPresentationControllerBlock(popPresenter);
    }
    
    
    [[self topViewController] presentViewController:alert animated:YES completion:nil];
    
    if (autoDismiss) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(WKAutoDismissTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        
    }
    
    return alert;
}

+ (instancetype)showWithTitle:(NSString *)title
                      message:(NSString *)message
               preferredStyle:(UIAlertControllerStyle)preferredStyle
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
popoverPresentationControllerBlock:(WKPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                       action:(void(^)(NSInteger index))tapAction
            otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION
{
    va_list ap;
    va_start(ap, firstTitle);
    UIAlertController *alert =  [self showWithTitle:title
                                            message:message
                                     preferredStyle:preferredStyle
                                  cancelButtonTitle:cancelButtonTitle
                             destructiveButtonTitle:destructiveButtonTitle
                 popoverPresentationControllerBlock:popoverPresentationControllerBlock
                                             action:tapAction
                                         firstTitle:firstTitle
                                             valist:ap
                                        autoDismiss:NO];
    
    va_end(ap);
    
    return alert;
}


/**
 点击消失
 
 @param title title
 @param message message
 @param cancelButtonTitle cancelButtonTitle
 @param destructiveButtonTitle destructiveButtonTitle
 @param tapAction tapAction
 @param firstTitle firstTitle
 @return alert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            action:(void(^)(NSInteger index))tapAction
                 otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION
{
    va_list ap;
    va_start(ap, firstTitle);
    UIAlertController *alert = [self showWithTitle:title
                                           message:message
                                    preferredStyle:UIAlertControllerStyleAlert
                                 cancelButtonTitle:cancelButtonTitle
                            destructiveButtonTitle:destructiveButtonTitle
                popoverPresentationControllerBlock:nil
                                            action:tapAction
                                        firstTitle:firstTitle
                                            valist:ap
                                       autoDismiss:NO];
    
    va_end(ap);
    return alert;
}

/**
 自动消失的alertView
 
 @param title title
 @param message message
 @param cancelButtonTitle cancelButtonTitle
 @param destructiveButtonTitle destructiveButtonTitle
 @param tapAction tapAction ·
 @param autoDismiss autoDismiss
 @param firstTitle firstTitle
 @return alert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            action:(void(^)(NSInteger index))tapAction
                       autoDismiss:(BOOL)autoDismiss
                 otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION

{
    va_list ap;
    va_start(ap, firstTitle);
    UIAlertController *alert = [self showWithTitle:title
                                           message:message
                                    preferredStyle:UIAlertControllerStyleAlert
                                 cancelButtonTitle:cancelButtonTitle
                            destructiveButtonTitle:destructiveButtonTitle
                popoverPresentationControllerBlock:nil
                                            action:tapAction
                                        firstTitle:firstTitle
                                            valist:ap
                                       autoDismiss:autoDismiss];
    
    va_end(ap);
    return alert;
}

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                  destructiveButtonTitle:(NSString *)destructiveButtonTitle
      popoverPresentationControllerBlock:(WKPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                  action:(void(^)(NSInteger index))tapAction
                       otherButtonTitles:(NSString *)firstTitle,...NS_REQUIRES_NIL_TERMINATION
{
    va_list ap;
    va_start(ap, firstTitle);
    
    UIAlertController *alert =  [self showWithTitle:title
                                            message:message
                                     preferredStyle:UIAlertControllerStyleActionSheet
                                  cancelButtonTitle:cancelButtonTitle
                             destructiveButtonTitle:destructiveButtonTitle
                 popoverPresentationControllerBlock:popoverPresentationControllerBlock
                                             action:tapAction
                                         firstTitle:firstTitle
                                             valist:ap
                                        autoDismiss:NO];
    
    va_end(ap);
    
    return alert;
}

#pragma mark - Auto dismiss
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
{
    return [self showAlertWithTitle:title
                            message:message
                  cancelButtonTitle:nil
             destructiveButtonTitle:nil
                             action:nil
                        autoDismiss:YES
                  otherButtonTitles:nil];
}



#pragma mark - root view controller
+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
    
}

@end


