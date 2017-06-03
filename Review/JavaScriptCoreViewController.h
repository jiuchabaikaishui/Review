//
//  JavaScriptCoreViewController.h
//  Review
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "SampleBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSIneract <JSExport>

- (void)showMessage:(NSString *)message;
- (void)doSomethingThenCallBack:(NSString *)message;
- (void)mixA:(NSString *)aString andB:(NSString*)bString;

@end

@interface JavaScriptCoreViewController : SampleBaseViewController

@end
