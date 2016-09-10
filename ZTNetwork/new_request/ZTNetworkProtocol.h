//
//  ZTNetworkProtocol.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/9.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol ZTNetworkProtocol <NSObject>

@optional

// Request delegate
@property (nonatomic, weak) id delegate;


// HTTP method to use (eg: GET / POST / PUT / DELETE / HEAD etc). Defaults to GET
@property (nonatomic, copy) NSString *requestMethod;


// Dictionary for custom HTTP request headers
@property (nonatomic, strong) NSMutableDictionary *requestHeaders;


// Can be used to manually insert cookie headers to a request, but it's more likely that sessionCookies will do this for you
@property (strong) NSMutableArray *requestCookies;


// Will be populated with HTTP response headers from the server
@property (strong) NSDictionary *responseHeaders;


// If allowCompressedResponse is true, requests will inform the server they can accept compressed data, and will automatically decompress gzipped responses. Default is true.
@property (nonatomic, assign) BOOL allowCompressedResponse;


// Number of seconds to wait before timing out - default is
@property (nonatomic, assign) NSTimeInterval timeOutSeconds;


// If an error occurs, error will contain an NSError
@property (nonatomic, strong) NSError *error;


// Set to allow a request to automatically retry itself on timeout
// Default is zero - timeout will stop the request
@property (nonatomic, assign) int numberOfTimesToRetryOnTimeout;


//Supply a client certificate
@property (nonatomic, strong) NSArray *clientCertificates;


// True if our 'cancel' selector has been called
@property (nonatomic, assign) BOOL cancelled;


// Run a request synchronously, and return control when the request completes or fails
- (void)startSynchronous;


// Run request in the background
- (void)startAsynchronous;


//Cancel the request
- (void)cancel;


// Set a POST variable for this request, clearing any others with the same key
- (void)setPostValue:(id <NSObject>)value forKey:(NSString *)key;


// Add a custom header to the request
- (void)addRequestHeader:(NSString *)header value:(NSString *)value;


// HTTP status code, eg: 200 = OK, 404 = Not found etc
- (int)responseStatusCode;


// Returns the contents of the result as an NSString (not appropriate for binary data - used responseData instead)
- (NSString *)responseString;


// Response data, automatically uncompressed where appropriate
- (NSData *)responseData;


// Convenience constructor
+ (id)requestWithURL:(NSURL *)newURL;



@end
