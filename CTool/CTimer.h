//
//  CTimer.h
//  CToolDemo
//
//  Created by sm on 2019/7/11.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTimer : NSObject


+ (CTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                           target:(id)target
                         selector:(SEL)selector
                          repeats:(BOOL)repeats;

- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                          target:(id)target
                        selector:(SEL)selector
                         repeats:(BOOL)repeats NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;

- (void)invalidate;

- (void)fire;




@end

NS_ASSUME_NONNULL_END
