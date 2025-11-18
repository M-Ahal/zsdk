#import "ZsdkPlugin.h"
#import "Messages.g.h"
#import "TcpPrinterConnection.h"

@implementation ZsdkPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // Set up the Pigeon-generated API
    ZsdkPlugin* instance = [[ZsdkPlugin alloc] init];
    SetUpZebraPrinting([registrar messenger], instance);
}

#pragma mark - ZebraPrinting implementation

- (nullable StatusInfo *)checkPrinterStatusOverTCPIPWithError:(FlutterError *_Nullable *_Nonnull)error {
    TcpPrinterConnection *zebraPrinterConnection = [[TcpPrinterConnection alloc] initWithAddress:@"192.168.1.100" andWithPort:6101];
    return [StatusInfo makeWithStatus:StatusUnknown cause:CauseUnknown];
}

@end