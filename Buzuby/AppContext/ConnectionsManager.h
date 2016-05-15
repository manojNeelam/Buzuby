
#define IsNULL(val) (val==nil || [val isKindOfClass:[NSNull class]])
#define safeAssign(dest, src) \
{	id value = src; \
if(value) \
dest = value; }

#define SAFE(src) \
src!=nil?src:NSNULL

#define IsNULL(val) (val==nil || [val isKindOfClass:[NSNull class]])

#define SAFE_DEF(value, default) ((value==nil)?(default):(value))

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"

@protocol ServerResponseDelegate <NSObject>
- (void) success:(id)response;
- (void) failure:(id)response;
@end

typedef void (^CompletionBlock)(NSDictionary *result, NSError *error);

@interface ConnectionsManager : AFHTTPRequestOperationManager <ServerResponseDelegate>

+ (instancetype)sharedManager;
-(void)getBannerData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getMyFaviroteData:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;

-(void)loginUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)registerUser:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;
-(void)getForgotPassword:(NSDictionary *)params withdelegate:(id<ServerResponseDelegate>) delegate;


@end