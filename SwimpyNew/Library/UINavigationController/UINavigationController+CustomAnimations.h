//
//  UINavigationController+CustomAnimations.h
//  Additions
//
//  Created by Sumeru Chatterjee on 12/12/11.
//

#import <UIKit/UIKit.h>

typedef enum {
    UINavigationCustomTransitionStyleZoom = 0,
    UINavigationCustomTransitionStyleCube,
    UINavigationCustomTransitionStyleFade,
    UINavigationCustomTransitionStyleRipple,
    UINavigationCustomTransitionStyleSuck,
    UINavigationCustomTransitionStyleCompleteFlip,
	UINavigationCustomTransitionStyleRightSuck,

} UINavigationCustomTransitionStyle;


@interface UINavigationController (CustomAnimations)

/*Push a view controller with a custom transition style*/
- (void)pushViewController:(UIViewController *)viewController withCustomTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;

/* Pop the top the view controller with a custom transition style*/
- (UIViewController *)popViewControllerwithCustomTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;

-(void)pushViewController:(UIViewController *) VC : (NSString *)Identifier;

@end
