#define kRWSettingsPath @"/var/mobile/Library/Preferences/com.lizynz.fullfolderx.plist"

#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height - 270
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width

@interface SBFolderIconBackgroundView : UIView
@end
@interface SBFolderIconImageView : UIView
@end

%hook SBFolderController

- (_Bool)_homescreenAndDockShouldFade {
       return YES;
}

%end

%hook SBFloatyFolderView

- (CGRect)_frameForScalingView { // Size Folder
        return (CGRect){{0, 270},{kScreenWidth, kScreenHeight}};
}

- (double)_titleVerticalOffsetForOrientation:(long long)arg1 { // Folder title top
        return 100;
}

- (double)_titleFontSize { // Font size title
       return 30;
}

- (_Bool)_shouldConvertToMultipleIconListsInLandscapeOrientation { // More page in landscape orientation
       return NO;
}

%end

%hook SBFolderBackgroundView

/*+ (CGSize)folderBackgroundSize {} // Size Folder

- (id)initWithFrame:(CGRect)arg1 { // Dark background
id view = %orig;
       [self setBackgroundColor:[UIColor colorWithWhite: 0.20 alpha:0.85]];
return view;
}*/

+ (double)cornerRadiusToInsetContent { // Folder background radius
        return 0;
}

- (void)layoutSubviews {} // Hide background

%end

%hook SBFolderIconListView

+ (unsigned int)maxVisibleIconRowsInterfaceOrientation:(int)interfaceOrientation {
              return 5; //number
}

+ (unsigned int)iconColumnsForInterfaceOrientation:(int)interfaceOrientation {
              return 3; //number

- (double)sideIconInset {
       return 20;
}

%end

/*%hook SBFolderIconBackgroundView

-(void)setWallpaperBackgroundRect:(CGRect)arg1 forContents:(CGImageRef)arg2 withFallbackColor:(CGColorRef)arg3 {
     return [self setBackgroundColor:[UIColor colorWithWhite: 0.20 alpha:0.85]]; // Folder icon dark
}

%end

%hook SBFolderIconView

- (void)layoutSubviews {
      %orig;
      MSHookIvar<UIView *>(self, "_labelView").hidden = YES; // Hide folder icon
}

%end

%hook SBIcon

- (id)gridCellImage { // Hide mini grid folder icon
     return nil;  
}

%end*/
