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

+ (BOOL)isJailbroken
{
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
        return YES;
    }
    file = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/bin/bash", "r");
    if (file) {
        fclose(file);
        return YES;
        
    }
    file = fopen("/usr/sbin/sshd", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/etc/apt", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/usr/bin/ssh", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/sbin/sshd"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/etc/apt"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/bin/ssh"]) {
        return YES;
    }
    
    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        return YES;
    }
    
    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        return YES;
    }
    
#endif
    
    return NO;
}

+ (BOOL)isJailbrokenWithCallback:(void (^)(NSString *path))callback 
{
#if !(TARGET_IPHONE_SIMULATOR)
    
    if (@available(iOS 14.0, *)) {
        if ([NSProcessInfo processInfo].isiOSAppOnMac)
        {
            return NO;
        }
    }
    FILE *file = fopen("/Applications/Cydia.app", "r");
    if (file) {
        if (callback) {
                      callback("/Applications/Cydia.app");
                  }
        fclose(file);
        return YES;
    }
    file = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (file) {
        if (callback) {
                      callback("/Library/MobileSubstrate/MobileSubstrate.dylib");
                  }
        fclose(file);
        return YES;
    }
    file = fopen("/bin/bash", "r");
    if (file) {
        if (callback) {
                      callback("/bin/bash");
                  }
        fclose(file);
        return YES;
        
    }
    file = fopen("/usr/sbin/sshd", "r");
    if (file) {
        if (callback) {
                      callback("/usr/sbin/sshd");
                  }
        fclose(file);
        return YES;
    }
    file = fopen("/etc/apt", "r");
    if (file) {
        if (callback) {
                      callback("/etc/apt");
                  }
        fclose(file);
        return YES;
    }
    file = fopen("/usr/bin/ssh", "r");
    if (file) {
        if (callback) {
                      callback("/usr/bin/ssh");
                  }
        fclose(file);
        return YES;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        if (callback) {
                      callback("/Applications/Cydia.app");
                  }
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        if (callback) {
                      callback("/Library/MobileSubstrate/MobileSubstrate.dylib");
                  }
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        if (callback) {
                      callback("/bin/bash");
                  }
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/sbin/sshd"]) {
        if (callback) {
                      callback("/usr/sbin/sshd");
                  }
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/etc/apt"]) {
        if (callback) {
                      callback("/etc/apt");
                  }
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/bin/ssh"]) {
        if (callback) {
                      callback("/usr/bin/ssh");
                  }
        return YES;
    }
    
    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        if (callback) {
                      callback("/private/jailbreak.txt");
                  }
        return YES;
    }
    
    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        if (callback) {
                      callback("cydia://package/com.example.package");
                  }
        return YES;
    }
    
#endif
    
    return NO;
}

@end
