//
//  ViewController.m
//  BundleDump
//
//  Created by Joe Blau on 7/29/19.
//  Copyright © 2019 Joe Blau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self _applicationIdentifiers];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (NSArray<NSString*>*)_applicationIdentifiers {
    NSMutableArray<NSString*>* identifiers = [NSMutableArray<NSString*> new];
    
    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    id defaultApplicationWorkspace = [LSApplicationWorkspace valueForKey:@"defaultWorkspace"];
    SEL selectorAllApplications = NSSelectorFromString(@"allApplications");
    
    id allApplications = [defaultApplicationWorkspace performSelector:selectorAllApplications];
    
    for (id appliction in allApplications) {
        SEL selectorApplicationIdentifier = NSSelectorFromString(@"applicationIdentifier");
        NSString *applicationIdentifier = (NSString *)[appliction performSelector:selectorApplicationIdentifier];
        SEL selectorItemName = NSSelectorFromString(@"localizedName");
        NSString *applicationItemName = (NSString *)[appliction performSelector:selectorItemName];
        
        NSLog(@"%@ - %@", applicationItemName, applicationIdentifier);
        [identifiers addObject:applicationIdentifier];
    }
    return identifiers;
}

#pragma clang diagnostic pop

@end
