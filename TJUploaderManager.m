//
//  TJUploaderManager.m
//  AreaApplication
//
//  Created by Lv Qiang on 2017/4/12.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "TJUploaderManager.h"
#import "AFNetworking.h"


@interface TJUploaderManager ()

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,strong)NSString * API_SERVER;

@end

/**
 *  请求api地址
 */
//static NSString * API_SERVER = @"https://app.medvision.com.cn:8001/AreaAppBaseServer/baseFunctionAction.do?verbId=uploadFiles&";

@implementation TJUploaderManager

+(TJUploaderManager *)sharedInstance {
    static TJUploaderManager *tjManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tjManager = [[TJUploaderManager alloc]init];
    });
    return tjManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"multipart/form-data"];
        _API_SERVER = [NSString stringWithFormat:@"%@%@",ZHReqAppBaseUrl,@"/baseFunctionAction.do?verbId=uploadFiles&"];
        if ([self isHttpPre:_API_SERVER]) {
            _manager.securityPolicy.allowInvalidCertificates = YES;
        }
    }
    return self;
}
- (BOOL)isHttpPre:(NSString *)path
{
    if (path && ([[ [path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString] hasPrefix:@"http://"])) {
        return YES;
    }
    else return NO;
}
- (void)uploadImageData:(NSArray <UIImage *>*)imageArr
              thumbnail:(BOOL)isThumbnail
               override:(BOOL)isOverride
          thumbnailSize:(CGSize)smallSize
         functionModule:(NSString *)module
               progress:(nullable void (^)(NSProgress *progress))progress
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *thumbnail = isThumbnail == YES?@"&thumbnail=true":@"&thumbnail=false";
    NSString *override = isOverride == YES?@"&override=true":@"&override=false";
    NSString *sizeString = smallSize.width != 0 ?[NSString stringWithFormat:@"&thumbnailWidth=%.0f&thumbnailHeight=%.0f",smallSize.width,smallSize.height]:@"";
    
    NSDate*  date = [NSDate date];
    NSDateFormatter *format = [NSDateFormatter new];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    [format setDateFormat:@"yyyyMMdd"];
    
    [_manager POST:[NSString stringWithFormat:@"%@%@%@%@",_API_SERVER,thumbnail,override,sizeString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        DLog(@"上传图片地址：%@====",[NSString stringWithFormat:@"%@%@%@%@",_API_SERVER,thumbnail,override,sizeString]);
        for (UIImage *image in imageArr) {
            NSString *nameStr = [NSString stringWithFormat:@"/upload/%@/%@/%@%@.jpg",module,[UserConfig sharedInstance].userId,[format stringFromDate:date],
                         [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString]];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1) name:nameStr fileName:nameStr mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];

}

- (void)uploadImageUrl:(NSArray <NSURL *>*)imageArr
              mimeType:(NSString *)mimeType
             thumbnail:(BOOL)isThumbnail
              override:(BOOL)isOverride
         thumbnailSize:(CGSize)smallSize
        functionModule:(NSString *)module
              progress:(nullable void (^)(NSProgress *progress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *thumbnail = isThumbnail == YES?@"&thumbnail=true":@"&thumbnail=false";
    NSString *override = isOverride == YES?@"&override=true":@"&override=false";
    NSString *sizeString = (smallSize.width != 0) ?[NSString stringWithFormat:@"&thumbnailWidth=%.0f&thumbnailHeight=%.0f",smallSize.width,smallSize.height]:@"";
    
    NSDate*  date = [NSDate date];
    NSDateFormatter *format = [NSDateFormatter new];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    [format setDateFormat:@"yyyyMMdd"];

    [_manager POST:[NSString stringWithFormat:@"%@%@%@%@",_API_SERVER,thumbnail,override,sizeString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *imageType = nil;
        if ([mimeType rangeOfString:@"png"].location != NSNotFound) {
            imageType = @"png";
        }else{
            imageType = @"jpg";
        }
        for (NSURL *imgUrl in imageArr) {
            NSString *nameStr = [NSString stringWithFormat:@"/%@/%@/%@%@.%@",module,@"userid",[format stringFromDate:date],
                                 [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString],imageType];
            [formData appendPartWithFileURL:imgUrl name:nameStr fileName:nameStr mimeType:mimeType error:nil];

        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];
    
}

- (void)uploadFileUrl:(NSArray <NSURL *>*)fileArr
             mimeType:(NSString *)mimeType
        fileExtension:(NSString *)extension
             override:(BOOL)isOverride
       functionModule:(NSString *)module
             progress:(nullable void (^)(NSProgress *progress))progress
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *thumbnail = @"&thumbnail=false";
    NSString *override = isOverride == YES?@"&override=true":@"&override=false";
    
    NSDate*  date = [NSDate date];
    NSDateFormatter *format = [NSDateFormatter new];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    [format setDateFormat:@"yyyyMMdd"];
    
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",_API_SERVER,thumbnail,override] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (NSURL *fileUrl in fileArr) {
            NSString *nameStr = [NSString stringWithFormat:@"/%@/%@/%@%@.%@",module,@"userid", [format stringFromDate:date],
                                 [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString],extension];
            [formData appendPartWithFileURL:fileUrl name:nameStr fileName:nameStr mimeType:mimeType error:nil];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];
    
}
- (void)uploadFileData:(NSArray <NSData *>*)fileArr
             mimeType:(NSString *)mimeType
        fileExtension:(NSString *)extension
             override:(BOOL)isOverride
       functionModule:(NSString *)module
             progress:(nullable void (^)(NSProgress *progress))progress
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure{
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *thumbnail = @"&thumbnail=false";
    NSString *override = isOverride == YES?@"&override=true":@"&override=false";
    
    NSDate*  date = [NSDate date];
    NSDateFormatter *format = [NSDateFormatter new];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    [format setDateFormat:@"yyyyMMdd"];
    
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",_API_SERVER,thumbnail,override] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSData *fileData in fileArr) {
            NSString *nameStr = [NSString stringWithFormat:@"/%@/%@/%@%@.%@",module,@"userid", [format stringFromDate:date],
                                 [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString],extension];
            [formData appendPartWithFileData:fileData name:nameStr fileName:nameStr mimeType:mimeType];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];
    
}

- (void)cancelAllOperations {
    [_manager.operationQueue cancelAllOperations];
}


@end
