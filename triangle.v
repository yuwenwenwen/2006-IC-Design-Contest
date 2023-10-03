module triangle (clk, reset, nt, xi, yi, busy, po, xo, yo);
  input clk, reset, nt;
  input [2:0] xi, yi;
  output busy, po;
  output [2:0] xo, yo;
  
                   
parameter INIT = 2'b00;
parameter WRITE = 2'b01;
parameter COUNT = 2'b10;
parameter FINAL = 2'b11;

reg [1:0] st_curr;
reg [1:0] st_next;

reg [2:0] x1,x2,x3,y1,y2,y3;
reg [2:0]x_count,y_count;
reg [2:0] xo,yo;
//reg signed [2:0] dx,dy,dx1,dy1;
//reg nt, 
reg busy,po;
reg gg1;
wire signed [7:0]gg;

assign gg = ( ( y3 - y_count )*(x2 - x3) - (y3 - y2 )*(x_count - x3));

always @(*) begin
  if(gg>0)
    gg1=1;
  else if(gg<0)
    gg1=0;
  //else if(gg=0)
    //gg1=1;
end

/*always@(posedge clk or posedge reset)begin
if(reset)
	nt<=1;
else 
  nt<=0;
end*/

always@(posedge clk)begin
if(x1!=0 && x2==0)
  busy<=1;
else if(xo==x2 && yo==y3)
  busy<=0;
end

always@(posedge clk or posedge reset or negedge clk)begin
if(reset)
	st_curr <= INIT;
else 
	st_curr <= st_next;
end

always@(*)begin
case(st_curr)
  INIT :begin 
  //if(nt)
  if(x1 == 0)
    st_next = WRITE;
  else 
    st_next = INIT;
    end

  WRITE : begin
  if((x3!=0)   &&    (y3 != 0))
    st_next = COUNT;
  else
    st_next = WRITE;end

  COUNT : begin
  if((x_count == x3)   &&    (y_count == y3))
    st_next = FINAL;
  else
    st_next = COUNT;end

  FINAL : begin
      st_next = INIT;end
endcase
end


always@(*)begin
if(st_curr==INIT)begin
    x1=0;x2=0;x3=0;x_count=0;po<=0;
    y1=0;y2=0;y3=0;y_count=0;xo<=0;yo<=0;
end
end


always@(posedge clk)begin
if(st_curr == WRITE)begin
  if(x1==0 && nt==1)begin
    x1<=xi;
    y1<=yi;  end
  if(x1!=0 && x2==0)begin
    x2<=xi;
    y2<=yi;
    x_count<=x1;
    y_count<=y1;
    busy<=1;end
  if(x2!=0 && x3==0)begin
    x3<=xi;
    y3<=yi;
    end
end
end

always@(posedge clk)begin
if(st_curr == COUNT)begin
  if((x_count == x2) && (y_count != y3))begin
    x_count<=x1;
    y_count<=y_count+1;end
  else 

    x_count<=x_count+1;
end
end

always@(posedge clk)begin
if(st_curr == COUNT)begin
  if(gg1)begin
    xo<=x_count;
    yo<=y_count;
    po<=1; 
    end
  else if(x_count==x3 && y_count==y3)begin
    xo<=x_count;
    yo<=y_count;
    po<=1; 
  end
  else begin
    xo<=0;
    yo<=0;
    po<=0;
        //dx1<=x_count-x3;
    //dy1<=y_count-y3; end
end
end
end


always@(*)begin
if(st_curr == FINAL)begin
  if(x_count==x3 && y_count==y3)begin
    xo<=x_count;
    yo<=y_count;
    po<=1; 
  end
  else begin
    xo<=0;
    yo<=0;
    po<=0;
end
end
end


//((x_count-x3)*(dy))<=((y_count-y3)*(dx))




endmodule
