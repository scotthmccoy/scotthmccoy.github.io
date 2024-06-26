
[http://nshipster.com/nserror/](http://nshipster.com/nserror/)

[https://developer.apple.com/documentation/foundation/nserror/1448136-nserror_codes](https://developer.apple.com/documentation/foundation/nserror/1448136-nserror_codes)

```
NS_ERROR_ENUM(NSURLErrorDomain)
{
    NSURLErrorUnknown = 			-1,
    NSURLErrorCancelled = 			-999,
    NSURLErrorBadURL = 				-1000,
    NSURLErrorTimedOut = 			-1001,
    NSURLErrorUnsupportedURL = 			-1002,
    NSURLErrorCannotFindHost = 			-1003,
    NSURLErrorCannotConnectToHost = 		-1004,
    NSURLErrorNetworkConnectionLost = 		-1005,
    NSURLErrorDNSLookupFailed = 		-1006,
    NSURLErrorHTTPTooManyRedirects = 		-1007,
    NSURLErrorResourceUnavailable = 		-1008,
    NSURLErrorNotConnectedToInternet = 		-1009,
    NSURLErrorRedirectToNonExistentLocation = 	-1010,
    NSURLErrorBadServerResponse = 		-1011,
    NSURLErrorUserCancelledAuthentication = 	-1012,
    NSURLErrorUserAuthenticationRequired = 	-1013,
    NSURLErrorZeroByteResource = 		-1014,
    NSURLErrorCannotDecodeRawData =             -1015,
    NSURLErrorCannotDecodeContentData =         -1016,
    NSURLErrorCannotParseResponse =             -1017,
    NSURLErrorAppTransportSecurityRequiresSecureConnection API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) = -1022,
    NSURLErrorFileDoesNotExist = 		-1100,
    NSURLErrorFileIsDirectory = 		-1101,
    NSURLErrorNoPermissionsToReadFile = 	-1102,
    NSURLErrorDataLengthExceedsMaximum API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)) =	-1103,
    NSURLErrorFileOutsideSafeArea API_AVAILABLE(macos(10.12.4), ios(10.3), watchos(3.2), tvos(10.2)) = -1104,
    
    // SSL errors
    NSURLErrorSecureConnectionFailed = 		-1200,
    NSURLErrorServerCertificateHasBadDate = 	-1201,
    NSURLErrorServerCertificateUntrusted = 	-1202,
    NSURLErrorServerCertificateHasUnknownRoot = -1203,
    NSURLErrorServerCertificateNotYetValid = 	-1204,
    NSURLErrorClientCertificateRejected = 	-1205,
    NSURLErrorClientCertificateRequired =	-1206,
    NSURLErrorCannotLoadFromNetwork = 		-2000,
    
    // Download and file I/O errors
    NSURLErrorCannotCreateFile = 		-3000,
    NSURLErrorCannotOpenFile = 			-3001,
    NSURLErrorCannotCloseFile = 		-3002,
    NSURLErrorCannotWriteToFile = 		-3003,
    NSURLErrorCannotRemoveFile = 		-3004,
    NSURLErrorCannotMoveFile = 			-3005,
    NSURLErrorDownloadDecodingFailedMidStream = -3006,
    NSURLErrorDownloadDecodingFailedToComplete =-3007,

    NSURLErrorInternationalRoamingOff API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0)) =         -1018,
    NSURLErrorCallIsActive API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0)) =                    -1019,
    NSURLErrorDataNotAllowed API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0)) =                  -1020,
    NSURLErrorRequestBodyStreamExhausted API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0)) =      -1021,
    
    NSURLErrorBackgroundSessionRequiresSharedContainer API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0)) = -995,
    NSURLErrorBackgroundSessionInUseByAnotherProcess API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0)) = -996,
    NSURLErrorBackgroundSessionWasDisconnected API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))= -997,
};
```
