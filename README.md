
## SFRマップ

|ID|名称|r/w?|機能|
|:--:|:--:|:--:|:--|
|0x00|NOP|r/w|-|
|0x01|TMR0_DIVR|r/w|timer0の分周比|
|0x02|TMR0L|r|timer0の0~7bit|
|0x03|TMR0H|r|timer0の8~15bit|
|0x04|PWM_DT|r/w|PWMのデッドタイム|
|0x05|PWM_PERIDO|r/w|PWMの周期|
|0x06|PWM1_DUTY|r/w|PWM1のON期間|
|0x07|PWM2_DUTY|r/w|PWM2のON期間|
|0x08|PWM3_DUTY|r/w|PWM3のON期間|
|0x09|ENC_PRSC|r/w|直交エンコーダーカウンタのプリスケーラ|
|0x0A|ENC|r/w|直交エンコーダーのカウント値|
|0x0B~|STDIO|r/w|標準入出力（シリアル通信）|