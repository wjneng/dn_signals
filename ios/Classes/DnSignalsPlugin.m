#import "DnSignalsPlugin.h"
#import "GDTAction.h"
#import "GDTAction+convenience.h"

@implementation DnSignalsPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dn_signals"
            binaryMessenger:[registrar messenger]];
  DnSignalsPlugin* instance = [[DnSignalsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  @try {
    if ([@"initialize" isEqualToString:call.method]) {
      [self initialize:call result:result];
    } else if ([@"start" isEqualToString:call.method]) {
      [GDTAction start];
      result(nil);
    } else if ([@"logAction" isEqualToString:call.method]) {
      [self logAction:call result:result];
    } else if ([@"getClickId" isEqualToString:call.method] ||
               [@"getChannelId" isEqualToString:call.method] ||
               [@"getAutoStartEnabled" isEqualToString:call.method]) {
      result(nil);
    } else if ([@"setAutoStartEnabled" isEqualToString:call.method] ||
               [@"setAnidEnabled" isEqualToString:call.method] ||
               [@"setUserUniqueId" isEqualToString:call.method]) {
      result(nil);
    } else if ([@"getCaid" isEqualToString:call.method]) {
      NSDictionary* caid = [GDTAction getCaid];
      result(caid);
    } else if ([self handleReportMethodCall:call result:result]) {
      return;
    } else {
      result(FlutterMethodNotImplemented);
    }
  } @catch (NSException* exception) {
    result([FlutterError errorWithCode:@"INVALID_ARGUMENT"
                               message:exception.reason
                               details:nil]);
  }
}

- (void)initialize:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary* args = [self requiredDictionary:call.arguments];
  NSString* actionSetId = [self requiredString:args key:@"actionSetId"];
  NSString* secretKey = [self requiredString:args key:@"secretKey"];
  [GDTAction init:actionSetId secretKey:secretKey];
  result(nil);
}

- (void)logAction:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary* args = [self requiredDictionary:call.arguments];
  NSString* actionName = [self requiredString:args key:@"actionName"];
  NSDictionary* parameters = [self optionalDictionary:args key:@"parameters"];
  [GDTAction logAction:actionName actionParam:parameters ?: @{}];
  result(nil);
}

- (BOOL)handleReportMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSSet* reportMethods = [NSSet setWithArray:@[
    @"reportRegister",
    @"reportLogin",
    @"reportBindAccount",
    @"reportQuestFinish",
    @"reportCreateRole",
    @"reportUpdateLevel",
    @"reportViewContent",
    @"reportAddToCart",
    @"reportCheckout",
    @"reportPurchase",
    @"reportAddPaymentChannel",
    @"reportRate",
    @"reportShare",
  ]];
  if (![reportMethods containsObject:call.method]) {
    return NO;
  }

  NSDictionary* args = [self requiredDictionary:call.arguments];

  if ([@"reportRegister" isEqualToString:call.method]) {
    [GDTAction reportRegisterActionWithMethod:[self requiredString:args key:@"method"]
                                    isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportLogin" isEqualToString:call.method]) {
    [GDTAction reportLoginActionWithMethod:[self requiredString:args key:@"method"]
                                 isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportBindAccount" isEqualToString:call.method]) {
    [GDTAction reportBindSocialAccountActionWithType:[self requiredString:args key:@"type"]
                                           isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportQuestFinish" isEqualToString:call.method]) {
    [GDTAction reportFinishQuestActionWithQuestID:[self requiredString:args key:@"questId"]
                                        questType:[self requiredString:args key:@"questType"]
                                        questName:[self requiredString:args key:@"questName"]
                                      questNumer:(NSUInteger)[self requiredInteger:args key:@"questNumber"]
                                      description:[self requiredString:args key:@"description"]
                                        isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportCreateRole" isEqualToString:call.method]) {
    [GDTAction reportCreateRoleActionWithRole:[self requiredString:args key:@"role"]];
  } else if ([@"reportUpdateLevel" isEqualToString:call.method]) {
    [GDTAction reportUpgradeLevelActionWithLevel:(NSUInteger)[self requiredInteger:args key:@"level"]];
  } else if ([@"reportViewContent" isEqualToString:call.method]) {
    [GDTAction reportViewContentActionWithContentType:[self requiredString:args key:@"contentType"]
                                          contentName:[self requiredString:args key:@"contentName"]
                                            contentID:[self requiredString:args key:@"contentId"]];
  } else if ([@"reportAddToCart" isEqualToString:call.method]) {
    [GDTAction reportAddingToCartActionWithContentType:[self requiredString:args key:@"contentType"]
                                           contentName:[self requiredString:args key:@"contentName"]
                                             contentID:[self requiredString:args key:@"contentId"]
                                         contentNumber:(NSUInteger)[self requiredInteger:args key:@"contentNumber"]
                                             isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportCheckout" isEqualToString:call.method]) {
    [GDTAction reportCheckoutActionWithContentType:[self requiredString:args key:@"contentType"]
                                       contentName:[self requiredString:args key:@"contentName"]
                                         contentID:[self requiredString:args key:@"contentId"]
                                     contentNumber:(NSUInteger)[self requiredInteger:args key:@"contentNumber"]
                                 isVirtualCurrency:[self requiredBool:args key:@"isVirtualCurrency"]
                               virtualCurrencyType:[self requiredString:args key:@"virtualCurrencyType"]
                                  realCurrencyType:[self requiredString:args key:@"realCurrencyType"]
                                         isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportPurchase" isEqualToString:call.method]) {
    [GDTAction reportPurchaseActionWithContentType:[self requiredString:args key:@"contentType"]
                                       contentName:[self requiredString:args key:@"contentName"]
                                         contentID:[self requiredString:args key:@"contentId"]
                                     contentNumber:(NSUInteger)[self requiredInteger:args key:@"contentNumber"]
                                    paymentChannel:[self requiredString:args key:@"paymentChannel"]
                                      realCurrency:[self requiredString:args key:@"realCurrency"]
                                    currencyAmount:(unsigned long long)[self requiredInteger:args key:@"currencyAmount"]
                                         isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportAddPaymentChannel" isEqualToString:call.method]) {
    [GDTAction reportAddPaymentChannelActionWithChannel:[self requiredString:args key:@"channel"]
                                              isSuccess:[self requiredBool:args key:@"isSuccess"]];
  } else if ([@"reportRate" isEqualToString:call.method]) {
    [GDTAction reportRateActionWithRate:(CGFloat)[self requiredDouble:args key:@"rate"]];
  } else if ([@"reportShare" isEqualToString:call.method]) {
    [GDTAction reportShareActionWithChannel:[self requiredString:args key:@"channel"]
                                  isSuccess:[self requiredBool:args key:@"isSuccess"]];
  }

  result(nil);
  return YES;
}

- (NSDictionary*)requiredDictionary:(id)value {
  if (![value isKindOfClass:[NSDictionary class]]) {
    [NSException raise:@"InvalidArguments" format:@"Arguments must be a map."];
  }
  return (NSDictionary*)value;
}

- (NSDictionary*)optionalDictionary:(NSDictionary*)args key:(NSString*)key {
  id value = args[key];
  if (value == nil || value == [NSNull null]) {
    return nil;
  }
  if (![value isKindOfClass:[NSDictionary class]]) {
    [NSException raise:@"InvalidArguments" format:@"%@ must be a map.", key];
  }
  return (NSDictionary*)value;
}

- (NSString*)requiredString:(NSDictionary*)args key:(NSString*)key {
  id value = args[key];
  if (![value isKindOfClass:[NSString class]] || [(NSString*)value length] == 0) {
    [NSException raise:@"InvalidArguments" format:@"%@ must be a non-empty string.", key];
  }
  return (NSString*)value;
}

- (BOOL)requiredBool:(NSDictionary*)args key:(NSString*)key {
  id value = args[key];
  if (![value isKindOfClass:[NSNumber class]]) {
    [NSException raise:@"InvalidArguments" format:@"%@ must be a boolean.", key];
  }
  return [(NSNumber*)value boolValue];
}

- (NSInteger)requiredInteger:(NSDictionary*)args key:(NSString*)key {
  id value = args[key];
  if (![value isKindOfClass:[NSNumber class]]) {
    [NSException raise:@"InvalidArguments" format:@"%@ must be a number.", key];
  }
  return [(NSNumber*)value integerValue];
}

- (double)requiredDouble:(NSDictionary*)args key:(NSString*)key {
  id value = args[key];
  if (![value isKindOfClass:[NSNumber class]]) {
    [NSException raise:@"InvalidArguments" format:@"%@ must be a number.", key];
  }
  return [(NSNumber*)value doubleValue];
}

@end
