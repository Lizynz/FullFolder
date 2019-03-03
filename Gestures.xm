@interface SBIconController : UIView
+ (id)sharedInstance;
- (void)handleHomeButtonTap;
- (_Bool)hasOpenFolder;
@end

@interface SBIcon : NSObject
- (void)launch;
- (void)launchFromLocation:(NSInteger)location;
- (void)launchFromLocation:(NSInteger)location context:(id)context;
- (void)launchFromLocation:(NSInteger)location context:(id)context activationSettings:(id)activationSettings actions:(id)actions;
- (void)openApplication;
@end

@interface SBIconView : UIView
@property(retain, nonatomic) SBIcon *icon;
@end


// AutoCloseFolder

%hook SBIcon

%new
- (void)openApplication {
         
         if([self respondsToSelector:@selector(launchFromLocation:context:activationSettings:actions:)]) {
             [self launchFromLocation:0 context:nil activationSettings:nil actions:nil];
         } else if([self respondsToSelector:@selector(launchFromLocation:context:)]) {
             [self launchFromLocation:0 context:nil];
         } else if ([self respondsToSelector:@selector(launchFromLocation:)]) {
             [self launchFromLocation:0];
         } else if ([self respondsToSelector:@selector(launch)]) {
             [self launch];
         }
      }
   }
}

%end

%hook SBIconController
- (void)iconTapped:(SBIconView *)iconView {
     if(self.hasOpenFolder) {
         [iconView.icon openApplication];
          [self handleHomeButtonTap];
    }
}
%end


//Tap to close

%hook SBFloatyFolderView

- (_Bool)_tapToCloseGestureRecognizer:(id)arg1 shouldReceiveTouch:(id)arg2 {
       return YES;
}

%end
