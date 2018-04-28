//
//  ZJByteData.c
//  CanShengHealth
//
//  Created by ZJ on 26/03/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#include "ZJByteData.h"

extern uint16_t bitReverse(uint16_t us_DataIn)
{
    uint16_t us_Data = us_DataIn;
    us_Data = ((us_Data & 0xFF00) >> 8) | ((us_Data & 0x00FF) << 8);
    us_Data = ((us_Data & 0xF0F0) >> 4) | ((us_Data & 0x0F0F) << 4);
    us_Data = ((us_Data & 0xCCCC) >> 2) | ((us_Data & 0x3333) << 2);
    us_Data = ((us_Data & 0xAAAA) >> 1) | ((us_Data & 0x5555) << 1);
    
    return (us_Data);
}

extern int valueWithIntBytes(Byte * bytes, uint16_t len)
{
    int byteVal[len];
    int value = 0;
    for (int j = 0; j < len; j++) {
        int a = (bytes[j] & 0xff) << ((len-1-j)*8);
        
        byteVal[j] = a;
    }
    for (int j = 0; j < len; j++) {
        value |= byteVal[j];
    }
 
    return value;
}

extern long valueWithLongBytes(Byte * bytes, uint16_t len)
{
    int byteVal[len];
    long value = 0;
    for (int j = 0; j < len; j++) {
        int a = (bytes[j] & 0xff) << ((len-1-j)*8);
        
        byteVal[j] = a;
    }
    for (int j = 0; j < len; j++) {
        value |= byteVal[j];
    }
    
    return value;
}

