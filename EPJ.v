module EPJ(clk,rst,a,unlock,enter,h1,h2,h3,h4);
output reg unlock;
input clk,rst,enter;
input [0:9]a;
output reg [0:6]h1;
output reg [0:6]h2;
output reg [0:6]h3;
output reg [0:6]h4;

reg [2:0] state;
reg [2:0] next_state;

parameter [2:0] s_rst = 3'b000;
parameter [2:0] s1 = 3'b001;
parameter [2:0] s2 = 3'b010;
parameter [2:0] s3 = 3'b011;
parameter [2:0] s4 = 3'b100;
parameter [2:0] s_crt = 3'b101;

always @(posedge clk)
begin
if(rst)
state = s_rst;
else
state = next_state;
end 
always @(state,a)
begin
case(state)
s_rst: 
begin
h1 = 7'b1111110;
h2 = 7'b1111110;
h3 = 7'b1111110;
h4 = 7'b1111110;
next_state=a[2] ? s1:s_rst; 
end
s1:
begin 
h1 = 7'b0010010;
h2 = 7'b1111110;
h3 = 7'b1111110;
h4 = 7'b1111110;
next_state=a[6] ? s2:s_rst; 
end
s2: 
begin 
h1 = 7'b0010010;
h2 = 7'b0100000;
h3 = 7'b1111110;
h4 = 7'b1111110;
next_state=a[0] ? s3:s_rst; 
end
s3: 
begin
h1 = 7'b0010010;
h2 = 7'b0100000;
h3 = 7'b0000001;
h4 = 7'b1111110;
next_state=a[1] ? s4:s_rst; 
end
s4: 
begin
h1 = 7'b0010010;
h2 = 7'b0100000;
h3 = 7'b0000001;
h4 = 7'b1001111;
next_state=enter ? s_crt:s_rst;
end
s_crt: 
begin
h1 = 7'b1000100;
h2 = 7'b0001000;
h3 = 7'b0100100;
h4 = 7'b0100100;
next_state=enter ? s_rst:s_rst;
end
default: next_state = s_rst;
endcase 
end
always @(state)
begin
case(state)
s_rst: unlock<=1'b0;
s1: unlock<=1'b0;
s2: unlock<=1'b0;
s3: unlock<=1'b0;
s4: unlock<=1'b0;
s_crt: unlock<=1'b1;
default: unlock<=1'b0;
endcase
end
endmodule 