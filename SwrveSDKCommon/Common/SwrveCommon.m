#import "SwrveCommon.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static id <SwrveCommonDelegate> _sharedInstance = NULL;

@implementation SwrveCommon

+ (void)addSharedInstance:(id <SwrveCommonDelegate>)sharedInstance {
    _sharedInstance = sharedInstance;
}

+ (id <SwrveCommonDelegate>)sharedInstance {
    return _sharedInstance;
}

+ (NSString *)swrveCacheFolder {
    NSString *cacheRoot = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *swrve_folder = @"com.ngt.msgs";
    NSString *cacheFolder = [cacheRoot stringByAppendingPathComponent:swrve_folder];
    return cacheFolder;
}

+(BOOL)supportedOS {
  // Detect if the SDK can run on this OS
  return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
}

+ (UIApplication *) sharedUIApplication {
    UIApplication* sharedApplication = nil;
    BOOL respondsToApplication = [UIApplication respondsToSelector:@selector(sharedApplication)];
    if (respondsToApplication) {
        sharedApplication = [UIApplication performSelector:@selector(sharedApplication)];
        if (!sharedApplication) {
            // WARNING: This should never be called from an extension
            NSException *exec = [[NSException alloc] initWithName:@"ApplicationNotAvailable" reason:@"Service Extensions can't access a shared application" userInfo:nil];
            [exec raise];
        }
    }
    
    return sharedApplication;
}

@end
