 /*
    @name:   delay time function (millisecond)
    @author: zhangpeng96
    @date:   2016/11/26
 */
void delay (unsigned int ms);
// declaration
void delay (unsigned int ms) {
	while ( ms-- ) {
		unsigned int j = 578;
        // suitable for 12C5A60S2, 12MHz
		while ( j-- );
	}
}

 /*
    @name:   delay time function (second)
    @author: zhangpeng96
    @date:   2016/11/26
 */
void delays (unsigned int s);
// declaration
void delays (unsigned int s) {
    while ( s-- ) {
        delay(1000);
    }
}
