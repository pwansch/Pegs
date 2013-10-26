//
//  MainView.h
//  Pegs
//
//  Created by Peter Wansch on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "Algorithm.h"
#import "PegView.h"

#define INSET_IPHONE    8
#define INSET_IPAD      16

@interface MainView : UIView

@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) Board board;
@property (strong, nonatomic) PegView *grabbedPeg;

- (void)invalidateText;
- (CGRect)boardRect:(short)x :(short)y;
- (short)getTouchXIndex:(NSSet *)touches;
- (short)getTouchYIndex:(NSSet *)touches;
- (PBoard)getBoardPointer;

@end


