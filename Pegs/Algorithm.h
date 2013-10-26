//
//  Algorithm.h
//  Pegs
//
//  Created by Peter Wansch on 10/19/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

// Alogrithm defines
#define DIVISIONS   9
#define EMPTY       0
#define BOARD       1
#define PIECE       2
#define CROSS       6
#define PLUS        9
#define FIREPLACE   11
#define UPARROW     17
#define PYRAMID     16
#define DIAMOND     24
#define SOLITAIRE   32

// Type definitions for board
typedef struct {
	short fState[DIVISIONS][DIVISIONS];
} Board;

typedef Board *PBoard;

typedef struct {
    int x;
    int y;
} BoardLocation;

// Function prototypes
BOOL IsOver(PBoard pBoard);
BOOL IsOK(PBoard pBoard, BoardLocation pt1, BoardLocation pt2, BoardLocation pt3);

