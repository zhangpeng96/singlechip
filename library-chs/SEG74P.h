#ifndef __SEG74P_H__
#define __SEG74P_H__

#include <stlo.h>

/* 定义管脚 */
sbit P_SEG74P_1 = P1^0;
sbit P_SEG74P_2 = P1^1;
sbit P_SEG74P_3 = P1^2;
sbit P_SEG74P_4 = P1^3;
// 位控制管脚
sfr  P_SEG74P   = 0x80;
// 段控制管脚

unsigned char _SEG74P_table[] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92,
	0x82, 0xf8, 0x80, 0x90, 0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e, 0xbf };
// 定义段管脚图像 (0 ~ F)

/*
   @name:   含小数点七段四位数码管显示函数
   @author: zhangpeng96
   @date:   2016/11/26
   @e.g.:   _SEG74P_display (输入数字的数组指针, 刷新时间, 小数点位);
   			刷新时间推荐使用小于50以内的数，不会产生闪烁现象（使用0也
   			是可以的）
   			小数点位可输入0~4控制小数点出现的位置，0为不显示。不可多显
   			示，其它数值无效会报错。
*/

void _SEG74P_display (unsigned int, unsigned int, unsigned int);
// 函数声明
void _SEG74P_display (unsigned int number[], unsigned int refresh_time, 
	unsigned int point) {
    unsigned int point_display[5] = {0xff, 0xff, 0xff, 0xff, 0xff};
    // 初始化小数点
    point_display[point] = 0x7f;
    // 将DP段设置为有效
    P_SEG74P_1 = 0;
    // 数码管位有效
    P_SEG74P  = _SEG74P_table[number[0]];
    // 载入段管脚
    P_SEG74P = P_SEG74P & point_display[1];
    // 载入小数点
    delay (refresh_time / 4);
    // 函数延时
    P_SEG74P = 0xff;
    // 段管脚清除
    P_SEG74P_1 = 1;
    // 数码管位关闭

    P_SEG74P_2 = 0;
    P_SEG74P = _SEG74P_table[number[1]];
    P_SEG74P = P_SEG74P & point_display[2];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_2 = 1;

    P_SEG74P_3 = 0;
    P_SEG74P = _SEG74P_table[number[2]];
    P_SEG74P = P_SEG74P & point_display[3];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_3 = 1;

    P_SEG74P_4 = 0;
    P_SEG74P = _SEG74P_table[number[3]];
    P_SEG74P = P_SEG74P & point_display[4];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_4 = 1;
}

#endif
