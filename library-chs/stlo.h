#ifndef __STLO_H__
#define __STLO_H__


   @name:   延时函数 (毫秒级)
   @author: zhangpeng96
   @date:   2016/11/26
*/
void delay (unsigned int);
// 函数声明
void delay (unsigned int) {
    while ( ms-- ) {
        unsigned int j = 568;
        // 该参数适用于 12C5A60S2型 CPU, 12MHz 的外源晶振
        while ( j-- );
    }
}

/*
   @name:   延时函数 (秒级)
   @author: zhangpeng96
   @date:   2016/11/26
*/
void delays (unsigned int);
// 函数声明
void delays (unsigned int s) {
    while ( s-- ) {
        delay(1000);
    }
}

 /*
    @name:   整数转数组函数
    @author: zhangpeng96
    @date:   2016/11/25
    @e.g.:   integer2array (输入的数字, 数组的指针, 数组长度)
             使用该函数之前，你需要先定义一个全局数组变量。
             例如：
                unsigned int data[4];
                integer2array(1234, data, 4);
             该函数不会返回值而是直接修改指定的全局数组变量的值。比如上面的例
             子之后会得到下面的结果：
                data[] = {1, 2, 3, 4};
             此外，该函数对于输入的数字位数小于数组的元素个数的输入以0填充，如
                integer2array(98, data, 4);
             将得到
                data[] = {0, 0, 9, 8};
 */

void integer2array (unsigned int, unsigned int, unsigned int);
// 函数声明
void integer2array (unsigned int digital, unsigned int arr[], unsigned int length) {
    unsigned int i, divide;
    // 声明变量
    divide = 1;
    // Divide 代表下面代码中的除数
    for ( i = 0; i < length; i++ ) {
        arr[length - i - 1] = digital / divide % 10;
        // 修改数组元素值
        divide = divide * 10;
        // 除数自增十倍
    }
}


 /*
    @name:   整数转时间表示函数（六十进制）
    @author: zhangpeng96
    @date:   2016/12/4
    @e.g.:   integer2clock (输入的数字, 数组的指针)
             使用该函数之前，你需要先定义一个全局数组变量。
             例如：
                unsigned int data[4];
                integer2clock(75, data);
             该函数不会返回值而是直接修改指定的全局数组变量的值。比如上面的例
             子之后会得到下面的结果：
                data[] = {0, 1, 1, 5};
 */
void integer2clock ( unsigned int, unsigned int );
// 函数声明
void integer2clock ( unsigned int digital, unsigned int arr[] ) {
    unsigned int hour, minute;
    // 声明变量
    hour = digital / 60;
    minute = digital % 60;
    // 除60得小时，取60的模得分钟数
    arr[0] = hour / 10;
    arr[1] = hour % 10;
    arr[2] = minute / 10;
    arr[3] = minute % 10;
    // 除10、取10的模将十位数分离
}

#endif
