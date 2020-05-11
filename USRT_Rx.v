module USRT_Rx(CLK,RST,SI,Rx_Byte, NINTI); 
input  CLK,RST, SI;
output reg [7:0] Rx_Byte;
output reg  NINTI; 

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001; 
parameter RECV_BIT = 3'b010;
parameter STOP_BIT = 3'b011; 


reg [2:0]state = 0; 
reg [2:0]Bit_Index = 0; 

always @(posedge CLK)
 begin 
  if (RST) 
			begin 
			state <= IDLE;
			NINTI <= 1'b0;
			end
  else 
   begin 
	 case (state)
	  IDLE: // IDLE
	    begin
		   if (SI==1'b0) 
		   begin 
		   NINTI <= 1'b1;
		   state <= START_BIT; 
			end 
	     else 
		   begin 
			 NINTI <= 1'b1;
		    state <= IDLE; 
	      end	
	   end 
	  START_BIT: 
	    begin 
		  NINTI <= 1'b0;		  
		  state <= RECV_BIT; 
		  Rx_Byte[Bit_Index] <= SI; //First bit of Data reception
		  Bit_Index = Bit_Index + 1; 
	    end 	
	  RECV_BIT: 
	    begin 
		  NINTI <= 1'b0;
		  Rx_Byte[Bit_Index] <= SI; //remaining 7 bit Data reception
		 
		  
		  if (Bit_Index < 7) 
		   begin
		    Bit_Index = Bit_Index + 1;
			 state <= RECV_BIT; 
	      end 	
		  else 
		   begin 
			 Bit_Index = 0; 
			 state <= STOP_BIT; 
			end 
		  
		 end 
	  STOP_BIT: 
	   begin 
		 NINTI <= 1'b1; 
		 state <= IDLE; 
		end 
	
	 endcase
	end 
 end 
endmodule 

