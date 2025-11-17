#import "ZsdkPlugin.h"
#import "Messages.g.h"

@implementation ZsdkPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // Set up the Pigeon-generated API
    ZsdkPlugin* instance = [[ZsdkPlugin alloc] init];
    SetUpZebraPrinting([registrar messenger], instance);
}

#pragma mark - ZebraPrinting implementation

- (nullable StatusInfo *)checkPrinterStatusOverTCPIPWithError:(FlutterError *_Nullable *_Nonnull)error {
    return [StatusInfo makeWithStatus:StatusUnknown cause:CauseUnknown];
}

@end