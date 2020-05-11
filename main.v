module main (Clock,Reset,SEND,Tx_Data,NINTO,NINTI,Rx_Data);

input Clock,Reset,SEND;
input [7:0] Tx_Data;
output [7:0] Rx_Data;
output NINTI,NINTO;

wire SO;

USRT_Tx Transmission(Clock, Reset, SEND, Tx_Data, SO, NINTO); 
USRT_Rx Reception(Clock,Reset,SO,Rx_Data, NINTI); 

endmodule
