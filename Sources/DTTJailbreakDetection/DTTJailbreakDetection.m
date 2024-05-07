//  DTTJailbreakDetection.m
//
//  Copyright (c) 2014 Doan Truong Thi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "DTTJailbreakDetection.h"

@implementation DTTJailbreakDetection

+ (JailbreakInfo)checkJailbreakStatus {
    
    JailbreakInfo info;
    info.isJailbroken = NO;
    info.jailbreakPath = @"";
    
    
#if !(TARGET_IPHONE_SIMULATOR)

    if (@available(iOS 14.0, *)) {
        if ([NSProcessInfo processInfo].isiOSAppOnMac)
        {
            return NO;
        }
    }
    FILE *file = fopen("/Applications/Cydia.app", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/Applications/Cydia.app";
        return info;
    }
    file = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/Library/MobileSubstrate/MobileSubstrate.dylib";
        return info;
    }
    file = fopen("/bin/bash", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/bin/bash";
        return info;
        
    }
    file = fopen("/usr/sbin/sshd", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/usr/sbin/sshd";
        return info;
    }
    file = fopen("/etc/apt", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/etc/apt";
        return info;
    }
    file = fopen("/usr/bin/ssh", "r");
    if (file) {
        fclose(file);
        info.isJailbroken = YES;
        info.jailbreakPath = @"/usr/bin/ssh";
        return info;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/Applications/Cydia.app";
        return info;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/Library/MobileSubstrate/MobileSubstrate.dylib";
        return info;
    } else if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/bin/bash";
        return info;
    } else if ([fileManager fileExistsAtPath:@"/usr/sbin/sshd"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/usr/sbin/sshd";
        return info;
    } else if ([fileManager fileExistsAtPath:@"/etc/apt"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/etc/apt";
        return info;
    } else if ([fileManager fileExistsAtPath:@"/usr/bin/ssh"]) {
        info.isJailbroken = YES;
        info.jailbreakPath = @"/usr/bin/ssh";
        return info;
    }
    
    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        info.isJailbroken = YES;
        return info;
    }
    
    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        info.isJailbroken = YES;
        return info;
    }
    
    
#endif
    
    return info;
}

@end

