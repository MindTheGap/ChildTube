#import <UIKit/UIKit.h>

typedef NS_ENUM( NSUInteger, SSCheckMarkStyle )
{
    SSCheckMarkStyleOpenCircle,
    SSCheckMarkStyleGrayedOut
};

@interface SSCheckMark : UIView

@property (nonatomic, readwrite) bool checked;
@property (nonatomic, readwrite) SSCheckMarkStyle checkMarkStyle;

@end