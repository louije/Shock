//
//  ShockWebBridge.m
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

// Unused. Made in Swift ultimately.

#import "ShockWebBridge.h"

@implementation ShockWebBridge

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    NSLog(@"%@ received %@ for '%@'", self, NSStringFromSelector(_cmd), NSStringFromSelector(selector));
    if (selector == @selector(clicked:)) {
        return NO;
    }
    return YES;
}

+ (NSString *) webScriptNameForSelector:(SEL)sel {
    NSLog(@"%@ received %@ with sel='%@'", self, NSStringFromSelector(_cmd), NSStringFromSelector(sel));
    if (sel == @selector(clicked:)) {
        return @"clicked";
    } else {
        return nil;
    }
}

- (int) clicked:(NSString *)event {
    NSLog(@"onclidk event %@", event);
    [NSApp terminate: self];
    return 0;
}



@end
