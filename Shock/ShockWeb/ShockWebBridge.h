//
//  ShockWebBridge.h
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

// Unused. Made in Swift ultimately.

#import <Foundation/Foundation.h>
#import <Webkit/Webkit.h>

@interface ShockWebBridge : NSObject
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector;
+ (NSString *) webScriptNameForSelector:(SEL)sel;
- (int)clicked:(NSString *)event;
@end
