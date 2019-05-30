
//
//  UserInfoManager.m
//  CWC
//
//  Created by sm on 2019/5/28.
//  Copyright © 2019 MAC. All rights reserved.
//


#import "UIView+CToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>


// 显示位置
#define defaultPosition         CSToastPositionBottom
// 是否一个一个依次显示
#define queueEnabled            NO
// 是否点击隐藏
#define tapToDismissEnabled     YES
// 显示时长
#define defaultDuration         2.0

#define defaultBackgroundColor  [[UIColor blackColor] colorWithAlphaComponent:0.8]
#define defaultTitleColor       [UIColor whiteColor]
#define messageColor            [UIColor whiteColor]
#define defaultShadowColor      [UIColor blackColor]
#define maxWidthPercentage      0.8
#define maxHeightPercentage     0.8
#define horizontalPadding       10.0
#define verticalPadding         10.0
#define defaultCornerRadius     10.0
#define titleFont               [UIFont boldSystemFontOfSize:16.0]
#define messageFont             [UIFont systemFontOfSize:16.0]
#define titleAlignment          NSTextAlignmentLeft
#define messageAlignment        NSTextAlignmentLeft
#define titleNumberOfLines      0
#define messageNumberOfLines    0
#define displayShadow           NO
#define defaultShadowOpacity    0.8
#define defaultShadowRadius     6.0
#define defaultShadowOffset     CGSizeMake(4.0, 4.0)
#define imageSize               CGSizeMake(80.0, 80.0)
#define activitySize            CGSizeMake(100.0, 100.0)
#define fadeDuration            0.2


// Positions
NSString * CSToastPositionTop                       = @"CSToastPositionTop";
NSString * CSToastPositionCenter                    = @"CSToastPositionCenter";
NSString * CSToastPositionBottom                    = @"CSToastPositionBottom";

// Keys for values associated with toast views
static const NSString * CSToastTimerKey             = @"CSToastTimerKey";
static const NSString * CSToastDurationKey          = @"CSToastDurationKey";
static const NSString * CSToastPositionKey          = @"CSToastPositionKey";
static const NSString * CSToastCompletionKey        = @"CSToastCompletionKey";

// Keys for values associated with self
static const NSString * CSToastActiveKey            = @"CSToastActiveKey";
static const NSString * CSToastActivityViewKey      = @"CSToastActivityViewKey";
static const NSString * CSToastQueueKey             = @"CSToastQueueKey";




#pragma mark =================================CSToastStyle=================================

@interface UIView (ToastPrivate)


- (void)cs_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position;
- (void)cs_hideToast:(UIView *)toast;
- (void)cs_hideToast:(UIView *)toast fromTap:(BOOL)fromTap;
- (void)cs_toastTimerDidFinish:(NSTimer *)timer;
- (void)cs_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)cs_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (NSMutableArray *)cs_toastQueue;

@end

@implementation UIView (Toast)

#pragma mark - Make Toast Methods

- (void)makeToast:(NSString *)message {
    UIView *toast = [self toastViewForMessage:message title:nil image:nil];
    [self showToast:toast duration:defaultDuration position:defaultPosition completion:nil];

}

#pragma mark - Show Toast Methods

- (void)showToast:(UIView *)toast {
    [self showToast:toast duration:defaultDuration position:defaultPosition completion:nil];
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position completion:(void(^)(BOOL didTap))completion {
    // sanity
    if (toast == nil) return;
    
    // store the completion block on the toast view
    objc_setAssociatedObject(toast, &CSToastCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (queueEnabled && [self.cs_activeToasts count] > 0) {
        // we're about to queue this toast view so we need to store the duration and position as well
        objc_setAssociatedObject(toast, &CSToastDurationKey, @(duration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(toast, &CSToastPositionKey, position, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // enqueue
        [self.cs_toastQueue addObject:toast];
    } else {
        // present
        [self cs_showToast:toast duration:duration position:position];
    }
}

#pragma mark - Hide Toast Methods

- (void)hideToast {
    [self hideToast:[[self cs_activeToasts] firstObject]];
}

- (void)hideToast:(UIView *)toast {
    // sanity
    if (!toast || ![[self cs_activeToasts] containsObject:toast]) return;
    
    [self cs_hideToast:toast];
}

- (void)hideAllToasts {
    [self hideAllToasts:NO clearQueue:YES];
}

- (void)hideAllToasts:(BOOL)includeActivity clearQueue:(BOOL)clearQueue {
    if (clearQueue) {
        [self clearToastQueue];
    }
    
    for (UIView *toast in [self cs_activeToasts]) {
        [self hideToast:toast];
    }
    
    if (includeActivity) {
        [self hideToastActivity];
    }
}

- (void)clearToastQueue {
    [[self cs_toastQueue] removeAllObjects];
}

#pragma mark - Private Show/Hide Methods

- (void)cs_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    toast.center = [self cs_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (tapToDismissEnabled) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cs_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [[self cs_activeToasts] addObject:toast];
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:fadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer timerWithTimeInterval:duration target:self selector:@selector(cs_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                         objc_setAssociatedObject(toast, &CSToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}

- (void)cs_hideToast:(UIView *)toast {
    [self cs_hideToast:toast fromTap:NO];
}
    
- (void)cs_hideToast:(UIView *)toast fromTap:(BOOL)fromTap {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(toast, &CSToastTimerKey);
    [timer invalidate];
    
    [UIView animateWithDuration:fadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                         
                         // remove
                         [[self cs_activeToasts] removeObject:toast];
                         
                         // execute the completion block, if necessary
                         void (^completion)(BOOL didTap) = objc_getAssociatedObject(toast, &CSToastCompletionKey);
                         if (completion) {
                             completion(fromTap);
                         }
                         
                         if ([self.cs_toastQueue count] > 0) {
                             // dequeue
                             UIView *nextToast = [[self cs_toastQueue] firstObject];
                             [[self cs_toastQueue] removeObjectAtIndex:0];
                             
                             // present the next toast
                             NSTimeInterval duration = [objc_getAssociatedObject(nextToast, &CSToastDurationKey) doubleValue];
                             id position = objc_getAssociatedObject(nextToast, &CSToastPositionKey);
                             [self cs_showToast:nextToast duration:duration position:position];
                         }
                     }];
}

#pragma mark - View Construction

- (UIView *)toastViewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if (message == nil && title == nil && image == nil) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = defaultCornerRadius;
    
    if (displayShadow) {
        wrapperView.layer.shadowColor = defaultShadowColor.CGColor;
        wrapperView.layer.shadowOpacity = defaultShadowOpacity;
        wrapperView.layer.shadowRadius = defaultShadowRadius;
        wrapperView.layer.shadowOffset = defaultShadowOffset;
    }
    
    wrapperView.backgroundColor = defaultBackgroundColor;
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(horizontalPadding, verticalPadding, imageSize.width, imageSize.height);
    }
    
    CGRect imageRect = CGRectZero;
    
    if(imageView != nil) {
        imageRect.origin.x = horizontalPadding;
        imageRect.origin.y = verticalPadding;
        imageRect.size.width = imageView.bounds.size.width;
        imageRect.size.height = imageView.bounds.size.height;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = titleNumberOfLines;
        titleLabel.font = titleFont;
        titleLabel.textAlignment = titleAlignment;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        titleLabel.textColor = defaultTitleColor;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * maxWidthPercentage) - imageRect.size.width, self.bounds.size.height * maxHeightPercentage);
        CGSize expectedSizeTitle = [titleLabel sizeThatFits:maxSizeTitle];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSizeMake(MIN(maxSizeTitle.width, expectedSizeTitle.width), MIN(maxSizeTitle.height, expectedSizeTitle.height));
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = messageNumberOfLines;
        messageLabel.font = messageFont;
        messageLabel.textAlignment = messageAlignment;
        messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        messageLabel.textColor = messageColor;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * maxWidthPercentage) - imageRect.size.width, self.bounds.size.height * maxHeightPercentage);
        CGSize expectedSizeMessage = [messageLabel sizeThatFits:maxSizeMessage];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeMessage = CGSizeMake(MIN(maxSizeMessage.width, expectedSizeMessage.width), MIN(maxSizeMessage.height, expectedSizeMessage.height));
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    CGRect titleRect = CGRectZero;
    
    if(titleLabel != nil) {
        titleRect.origin.x = imageRect.origin.x + imageRect.size.width + horizontalPadding;
        titleRect.origin.y = verticalPadding;
        titleRect.size.width = titleLabel.bounds.size.width;
        titleRect.size.height = titleLabel.bounds.size.height;
    }
    
    CGRect messageRect = CGRectZero;
    
    if(messageLabel != nil) {
        messageRect.origin.x = imageRect.origin.x + imageRect.size.width + horizontalPadding;
        messageRect.origin.y = titleRect.origin.y + titleRect.size.height + verticalPadding;
        messageRect.size.width = messageLabel.bounds.size.width;
        messageRect.size.height = messageLabel.bounds.size.height;
    }
    
    CGFloat longerWidth = MAX(titleRect.size.width, messageRect.size.width);
    CGFloat longerX = MAX(titleRect.origin.x, messageRect.origin.x);
    
    // Wrapper width uses the longerWidth or the image width, whatever is larger. Same logic applies to the wrapper height.
    CGFloat wrapperWidth = MAX((imageRect.size.width + (horizontalPadding * 2.0)), (longerX + longerWidth + horizontalPadding));
    CGFloat wrapperHeight = MAX((messageRect.origin.y + messageRect.size.height + verticalPadding), (imageRect.size.height + (verticalPadding * 2.0)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = titleRect;
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = messageRect;
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

#pragma mark - Storage

- (NSMutableArray *)cs_activeToasts {
    NSMutableArray *cs_activeToasts = objc_getAssociatedObject(self, &CSToastActiveKey);
    if (cs_activeToasts == nil) {
        cs_activeToasts = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &CSToastActiveKey, cs_activeToasts, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cs_activeToasts;
}

- (NSMutableArray *)cs_toastQueue {
    NSMutableArray *cs_toastQueue = objc_getAssociatedObject(self, &CSToastQueueKey);
    if (cs_toastQueue == nil) {
        cs_toastQueue = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &CSToastQueueKey, cs_toastQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cs_toastQueue;
}

#pragma mark - Events

- (void)cs_toastTimerDidFinish:(NSTimer *)timer {
    [self cs_hideToast:(UIView *)timer.userInfo];
}

- (void)cs_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    UIView *toast = recognizer.view;
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(toast, &CSToastTimerKey);
    [timer invalidate];
    
    [self cs_hideToast:toast fromTap:YES];
}

#pragma mark - Activity Methods

- (void)makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, activitySize.width, activitySize.height)];
    activityView.center = [self cs_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = defaultBackgroundColor;
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = defaultCornerRadius;
    
    if (displayShadow) {
        activityView.layer.shadowColor = defaultShadowColor.CGColor;
        activityView.layer.shadowOpacity = defaultShadowOpacity;
        activityView.layer.shadowRadius = defaultShadowRadius;
        activityView.layer.shadowOffset = defaultShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &CSToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:fadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:fadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &CSToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)cs_centerPointForPosition:(id)point withToast:(UIView *)toast {
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeInsets = self.safeAreaInsets;
    }
    
    CGFloat topPadding = verticalPadding + safeInsets.top;
    CGFloat bottomPadding = verticalPadding + safeInsets.bottom;
    
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:CSToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2.0, (toast.frame.size.height / 2.0) + topPadding);
        } else if([point caseInsensitiveCompare:CSToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width / 2.0, (self.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding);
}

@end

