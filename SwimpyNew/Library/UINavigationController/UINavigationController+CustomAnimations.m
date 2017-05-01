//
//  UINavigationController+CustomAnimations.m
//  Additions
//
//  Created by Sumeru Chatterjee on 12/12/11.
//

#import "UINavigationController+CustomAnimations.h"

//QuartzCore
#import <QuartzCore/QuartzCore.h>

#define kDefaultTransitionDuration 0.4

typedef enum {
	AnimationMethodUIViewAnimation=0,
	AnimationMethodCATransitionAnimation,
	AnimationMethodUndefined
} AnimationMethod;

typedef void(^AnimationBlock)(void);
typedef void(^CompletionBlock)(BOOL);
typedef void(^InitializationBlock)(void);
typedef void(^TransitionBlock)(void);

@interface UINavigationController (Private)

- (AnimationMethod) animationMethodForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;
- (CFTimeInterval) animationDurationFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;
- (InitializationBlock) viewAnimationInitializationBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward;
- (AnimationBlock) viewAnimationAnimationBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward;
- (CompletionBlock) viewAnimationCompletionBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward;
- (TransitionBlock) transitionBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward;
-(UIViewAnimationOptions) viewAnimationOptionsForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle forward:(BOOL)forward;
- (NSString*)transitionTypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;
- (NSString*)transitionForwardSubtypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;
- (NSString*)transitionBackwardSubtypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle;


@end

@implementation UINavigationController (CustomAnimations)



- (void)pushViewController:(UIViewController *)viewController withCustomTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	[viewController.view setFrame:self.topViewController.view.frame];
	
	if ([self animationMethodForTransitionStyle:transitionStyle]== AnimationMethodUIViewAnimation ) {
		
		[self viewAnimationInitializationBlockForTransitionStyle:transitionStyle controller:viewController forward:YES]();
		[UIView animateWithDuration:[self animationDurationFromTransitionStyle:transitionStyle]
							  delay:0
							options:[self viewAnimationOptionsForTransitionStyle:transitionStyle forward:YES]
						 animations:[self viewAnimationAnimationBlockForTransitionStyle:transitionStyle controller:viewController forward:YES]
						 completion:^(BOOL finished){
							 [self viewAnimationCompletionBlockForTransitionStyle:transitionStyle controller:viewController forward:YES](finished);
							 [self pushViewController:viewController animated:NO];
						 }];
		
	} else {
		
		[self transitionBlockForTransitionStyle:transitionStyle controller:viewController forward:YES]();
		
		[self pushViewController:viewController animated:NO];
	}
}

- (UIViewController *)popViewControllerwithCustomTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	UIViewController* returnViewController = nil;
	
	UIViewController* viewController = self.topViewController;
	if ([self animationMethodForTransitionStyle:transitionStyle]== AnimationMethodUIViewAnimation ) {
		
		returnViewController = [self popViewControllerAnimated:NO];
		[self viewAnimationInitializationBlockForTransitionStyle:transitionStyle controller:viewController forward:NO]();
		[UIView animateWithDuration:[self animationDurationFromTransitionStyle:transitionStyle]
							  delay:0
							options:[self viewAnimationOptionsForTransitionStyle:transitionStyle forward:NO]
						 animations:[self viewAnimationAnimationBlockForTransitionStyle:transitionStyle controller:viewController forward:NO]
						 completion:[self viewAnimationCompletionBlockForTransitionStyle:transitionStyle controller:viewController forward:NO]];
		
	} else {
	
        [self transitionBlockForTransitionStyle:transitionStyle controller:viewController forward:NO]();
		returnViewController = [self popViewControllerAnimated:NO];
	}
	
	return returnViewController;
}

#pragma mark -
#pragma mark Private Methods

- (AnimationMethod) animationMethodForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	if (transitionStyle == UINavigationCustomTransitionStyleZoom) {
		return AnimationMethodUIViewAnimation;
	}
	else {
		return AnimationMethodCATransitionAnimation;
	}
}

- (CFTimeInterval) animationDurationFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleZoom:
			return 0.4f;
		case UINavigationCustomTransitionStyleRipple:
			return 1.2f;
		default:
			return kDefaultTransitionDuration;
	}
}

// Helper Methods for AnimationMethodUIViewAnimation

-(InitializationBlock) viewAnimationInitializationBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleZoom:
			if (forward) {
				return [^{
					[[self.topViewController view] addSubview:controller.view];
					[controller viewWillAppear:YES];
					controller.view.transform=CGAffineTransformMakeScale(0.001, 0.001);
				} copy];
				
			} else {
				return [^{
					[[self.topViewController view] addSubview:controller.view];
				} copy];
			}
			
		default:
			return [^{} copy];;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(AnimationBlock) viewAnimationAnimationBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleZoom:
			if (forward) {
				return [^{
					controller.view.transform=CGAffineTransformMakeScale(1, 1);
				} copy];
				
			} else {
				return [^{
					controller.view.transform=CGAffineTransformMakeScale(0.001, 0.001);
				} copy];
			}
			
		default:
			return [^{} copy];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(CompletionBlock) viewAnimationCompletionBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleZoom:
			if (forward) {
				return [^{
					[controller.view removeFromSuperview];
				} copy];
				
			} else {
				return [^{
					[controller.view removeFromSuperview];
					controller.view.transform=CGAffineTransformMakeScale(1, 1);
				} copy];
			}
		default:
			return [^{} copy];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UIViewAnimationOptions) viewAnimationOptionsForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle forward:(BOOL)forward
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleZoom:
			return forward?UIViewAnimationOptionCurveEaseOut:UIViewAnimationOptionCurveEaseIn;
		default:
			return UIViewAnimationOptionCurveEaseInOut;
	}
}

// Helper Methods for AnimationMethodCATransitionAnimation

- (TransitionBlock) transitionBlockForTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle controller:(UIViewController*)controller forward:(BOOL)forward;
{
	if (forward) {
		return [^{
			CATransition *transition = [CATransition animation];
			transition.duration = [self animationDurationFromTransitionStyle:transitionStyle];
			transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
			
			transition.type = [self transitionTypeFromTransitionStyle:transitionStyle];
			transition.subtype = [self transitionForwardSubtypeFromTransitionStyle:transitionStyle];
			
			[[self.view layer] addAnimation:transition forKey:@"transition"];
			
		} copy];
		
	} else {
		return [^{
			CATransition *transition = [CATransition animation];
			transition.duration = [self animationDurationFromTransitionStyle:transitionStyle];
			transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
			
			transition.type = [self transitionTypeFromTransitionStyle:transitionStyle];
			transition.subtype =  [self transitionBackwardSubtypeFromTransitionStyle:transitionStyle];
			
			[[self.view layer] addAnimation:transition forKey:@"transition"];
		} copy];
	}
}

- (NSString*)transitionTypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	switch (transitionStyle) {
			
		case UINavigationCustomTransitionStyleCube:
			return @"cube";
		case UINavigationCustomTransitionStyleFade:
			return @"fade";
		case UINavigationCustomTransitionStyleRipple:
			return @"rippleEffect";
		case UINavigationCustomTransitionStyleSuck:
			return @"suckEffect";
		case UINavigationCustomTransitionStyleCompleteFlip:
			return @"flip";
		case UINavigationCustomTransitionStyleRightSuck:
			return @"suckEffectRight";
		default:
			return nil;
	}
}

- (NSString*)transitionForwardSubtypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	switch (transitionStyle) {
			
		case UINavigationCustomTransitionStyleCube:
			return kCATransitionFromBottom;
			
		case UINavigationCustomTransitionStyleCompleteFlip:
			return kCATransitionFromRight;
		case UINavigationCustomTransitionStyleRightSuck:
			return kCATransitionFromRight;
		default:
			return nil;
	}
}

- (NSString*)transitionBackwardSubtypeFromTransitionStyle:(UINavigationCustomTransitionStyle)transitionStyle
{
	switch (transitionStyle) {
		case UINavigationCustomTransitionStyleCube:
			return kCATransitionFromTop;
		case UINavigationCustomTransitionStyleCompleteFlip:
			return kCATransitionFromLeft;
		default:
			return [self transitionForwardSubtypeFromTransitionStyle:transitionStyle];
	}
}


-(void)CurlUP{
	
	[UIView  beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	//	[self.navigationController pushViewController:viewController animated:NO];
	
	self.navigationController.view.layer.cornerRadius = self.view.frame.size.width/2;
	self.navigationController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);

	
	[UIView animateWithDuration:0.0 animations:^{
		
		self.navigationController.view.layer.cornerRadius = 0.0;

		self.navigationController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
		
	} completion:^(BOOL finished) {
		
	}];
	
	
	//[UIView setAnimationTransition:UIViewAutoresizingFlexibleWidth forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
}

-(void)pushViewController:(UIViewController *) VC : (NSString *)Identifier{
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    VC = [storyBoard instantiateViewControllerWithIdentifier:Identifier];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.navigationController pushViewController:VC animated:YES];
    
    });
    
}


@end
