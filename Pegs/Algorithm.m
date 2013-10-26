//
//  Algorithm.m
//  Pegs
//
//  Created by Peter Wansch on 10/19/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import "Algorithm.h"

BOOL IsOver(PBoard pBoard)
{
    BoardLocation pt1, pt2, pt3;
    
    /* horizontal */
    pt1.x = 3; pt1.y = 7; pt2.x = 4; pt2.y = 7; pt3.x = 5; pt3.y = 7;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 3; pt1.y = 6; pt2.x = 4; pt2.y = 6; pt3.x = 5; pt3.y = 6;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.x = 1; pt1.y = 5; pt2.x = 2; pt2.y = 5; pt3.x = 3; pt3.y = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 2; pt1.y = 5; pt2.x = 3; pt2.y = 5; pt3.x = 4; pt3.y = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 3; pt1.y = 5; pt2.x = 4; pt2.y = 5; pt3.x = 5; pt3.y = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 4; pt1.y = 5; pt2.x = 5; pt2.y = 5; pt3.x = 6; pt3.y = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 5; pt1.y = 5; pt2.x = 6; pt2.y = 5; pt3.x = 7; pt3.y = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.x = 1; pt1.y = 4; pt2.x = 2; pt2.y = 4; pt3.x = 3; pt3.y = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 2; pt1.y = 4; pt2.x = 3; pt2.y = 4; pt3.x = 4; pt3.y = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 3; pt1.y = 4; pt2.x = 4; pt2.y = 4; pt3.x = 5; pt3.y = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 4; pt1.y = 4; pt2.x = 5; pt2.y = 4; pt3.x = 6; pt3.y = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 5; pt1.y = 4; pt2.x = 6; pt2.y = 4; pt3.x = 7; pt3.y = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.x = 1; pt1.y = 3; pt2.x = 2; pt2.y = 3; pt3.x = 3; pt3.y = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 2; pt1.y = 3; pt2.x = 3; pt2.y = 3; pt3.x = 4; pt3.y = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 3; pt1.y = 3; pt2.x = 4; pt2.y = 3; pt3.x = 5; pt3.y = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 4; pt1.y = 3; pt2.x = 5; pt2.y = 3; pt3.x = 6; pt3.y = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 5; pt1.y = 3; pt2.x = 6; pt2.y = 3; pt3.x = 7; pt3.y = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.x = 3; pt1.y = 2; pt2.x = 4; pt2.y = 2; pt3.x = 5; pt3.y = 2;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.x = 3; pt1.y = 1; pt2.x = 4; pt2.y = 1; pt3.x = 5; pt3.y = 1;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    /* vertical */
    pt1.y = 3; pt1.x = 7; pt2.y = 4; pt2.x = 7; pt3.y = 5; pt3.x = 7;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 3; pt1.x = 6; pt2.y = 4; pt2.x = 6; pt3.y = 5; pt3.x = 6;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.y = 1; pt1.x = 5; pt2.y = 2; pt2.x = 5; pt3.y = 3; pt3.x = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 2; pt1.x = 5; pt2.y = 3; pt2.x = 5; pt3.y = 4; pt3.x = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 3; pt1.x = 5; pt2.y = 4; pt2.x = 5; pt3.y = 5; pt3.x = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 4; pt1.x = 5; pt2.y = 5; pt2.x = 5; pt3.y = 6; pt3.x = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 5; pt1.x = 5; pt2.y = 6; pt2.x = 5; pt3.y = 7; pt3.x = 5;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.y = 1; pt1.x = 4; pt2.y = 2; pt2.x = 4; pt3.y = 3; pt3.x = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 2; pt1.x = 4; pt2.y = 3; pt2.x = 4; pt3.y = 4; pt3.x = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 3; pt1.x = 4; pt2.y = 4; pt2.x = 4; pt3.y = 5; pt3.x = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 4; pt1.x = 4; pt2.y = 5; pt2.x = 4; pt3.y = 6; pt3.x = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 5; pt1.x = 4; pt2.y = 6; pt2.x = 4; pt3.y = 7; pt3.x = 4;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.y = 1; pt1.x = 3; pt2.y = 2; pt2.x = 3; pt3.y = 3; pt3.x = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 2; pt1.x = 3; pt2.y = 3; pt2.x = 3; pt3.y = 4; pt3.x = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 3; pt1.x = 3; pt2.y = 4; pt2.x = 3; pt3.y = 5; pt3.x = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 4; pt1.x = 3; pt2.y = 5; pt2.x = 3; pt3.y = 6; pt3.x = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 5; pt1.x = 3; pt2.y = 6; pt2.x = 3; pt3.y = 7; pt3.x = 3;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    pt1.y = 3; pt1.x = 2; pt2.y = 4; pt2.x = 2; pt3.y = 5; pt3.x = 2;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    pt1.y = 3; pt1.x = 1; pt2.y = 4; pt2.x = 1; pt3.y = 5; pt3.x = 1;
    if (IsOK(pBoard, pt1, pt2, pt3))
        return NO;
    
    return YES;
}

BOOL IsOK(PBoard pBoard, BoardLocation pt1, BoardLocation pt2, BoardLocation pt3)
{
    if (pBoard->fState[pt2.x][pt2.y] == BOARD)
        return NO;
    if ((pBoard->fState[pt1.x][pt1.y] + pBoard->fState[pt2.x][pt2.y] + pBoard->fState[pt3.x][pt3.y]) == (2 * PIECE + BOARD))
        return YES;
    else
        return NO;
}


