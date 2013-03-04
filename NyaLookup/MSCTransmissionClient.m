//
//  MSCTransmissionClient.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 03.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCTransmissionClient.h"

@implementation MSCTransmissionClient

@synthesize preferences;
@synthesize sessionID;

+ (id) client:(MSCPreferences*)prefs
{
    MSCTransmissionClient* client = [[MSCTransmissionClient alloc] init];
    if (client == nil) {
        return nil;
    }
    
    client.preferences = prefs;
    client.sessionID = nil;
    
    return client;
}

- (id) torrentAdd:(NSString*) url
{
    NSLog(@"transmission torrent-add: %@", url);
    
    NSDictionary* args = @{ @"method"    : @"torrent-add",
                            @"arguments" : @{ @"filename": url } };
    
    return [self send: args];
}

- (id) send: (NSDictionary*) data
{
    NSLog(@"transmission send");
    if (self.sessionID == nil) {
        NSLog(@"session id is nil, need to get session header");
        NSURLRequest* request = [self request:@{ @"method": @"torrent-get" }];
        self.sessionID = [self getSessionID: request];
    }
    
    if (self.sessionID == nil) {
        NSLog(@"session id is still nil, unable send message");
        return nil;
    }
    
    NSURLRequest* request = [self request:data];
    id json = [self response: request];
    
    NSLog(@"%@", json);
    return json;
}

- (id) response: (NSURLRequest*)request
{
    NSLog(@"transmission response");
    
    NSData *urlData;
    NSHTTPURLResponse *response;
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response error:nil];
    
    NSLog(@"transmission response status: %ld", response.statusCode);
    
    if (response.statusCode == 409) {
        NSDictionary* respdic = [response allHeaderFields];
        NSLog(@"%@", [respdic valueForKey:@"X-Transmission-Session-Id"]);
    }
    
    return [urlData json];
}

- (NSString*) getSessionID: (NSURLRequest*)request
{
    NSLog(@"transmission getSessionID");
    
    NSData *urlData;
    NSHTTPURLResponse *response;
    urlData = [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response error:nil];
    
    NSDictionary* respdic = [response allHeaderFields];
    NSString* sid = [respdic valueForKey:@"X-Transmission-Session-Id"];
    
    if (sid != nil) {
        NSLog(@"X-Transmission-Session-Id: %@", sid);
    } else {
        NSLog(@"X-Transmission-Session-Id is nil, "
              @"looks like transmission daemon is not available");
    }
    return sid;
}

- (NSURLRequest*) request: (NSDictionary*)data
{
    NSLog(@"transmission request");
    
    NSData*             postData = [data toJSON];
    NSString*         postLength = [NSString stringWithFormat:@"%ld", [postData length]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:self.preferences.transmissionServer]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:self.sessionID forHTTPHeaderField:@"X-Transmission-Session-Id"];
    [request setHTTPBody:postData];
    
    return request;
}

@end
