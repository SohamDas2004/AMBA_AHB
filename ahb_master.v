module ahb_master (
    input hclk,
    input hresetn,
    input enable,
    input [31:0] data_in_a,
    input [31:0] data_in_b,
    input [31:0] addr,
    input wr,
    input hreadyout,
    input hresp, 
    input [31:0] hrdata,
    input [1:0] slave_sel, 

    output reg [1:0] sel,
    output reg[31:0] haddr,
    output reg hwrite,
    output reg [2:0] hsize,
    output reg [2:0] hburst, 
    output reg [3:0] hprot,
    output reg [1:0] htrans,
    output reg hready,
    output reg [31:0] hwdata,
    output reg [31:0] dout);

    // now we will define some parametrs which will be used in state machine

    reg [1:0] present_state, next_state;
    parameter idle : 2'b00;
    parameter sl   : 2'b01;
    parameter s2   : 2'b10;
    parameter s3   : 2'b11;

    // now the present state logic

    always @(posedge (hclk)) begin
        if (!hresetn) begin
            present_state <= idle;
        end
        else
            begin
                present_state <= next_state;
            end    
    end

    //next state logic
    always @(*) begin
        case (present_state)
                idle : begin
                sel <= 2'b00;
                haddr <= 32'h0000_0000;
                hwrite <= 1'b0;
                hsize <= 3'b000;
                hburst <=  3'b000;
                hprot <= 4'b0000;
                htrans <= 2'b00;
                hready <= 1'b0;
                hwdata <= 32'h0000_0000;
                dout <= 32'h0000_0000;

                if (enable == 1'b1) begin
                    next_state = s1;
                end
                else begin
                    next_state <= idle;
                end
                end

                s1: begin
                sel <= slave_sel;
                haddr <= addr;
                hwrite <= wr;
                hburst <=  3'b000;
                hready <= 1'b0;
                hwdata <= data_in_a+ data_in_b;
                dout <= dout;
                
                if (wr == 1'b1) 
                    begin
                        next_state = s2;
                    end
                else
                    begin
                        next_state= s3;
                    end
                end

                s2: begin
                sel <= slave_sel;
                haddr <= addr;
                hwrite <= wr;
                hburst <=  3'b000;
                hready <= 1'b1;
                hwdata <= data_in_a+ data_in_b;
                dout <= dout;

                if (enable = 1'b1) begin
                    next_state <= s1;
                end    
                else begin
                    next_state <= idle;
                end
                end

                s3: begin
                sel <= slave_sel;
                haddr <= addr;
                hwrite <= wr;
                hburst <=  3'b000;
                hready <= 1'b1;
                hwdata <= hwdata;
                dout <= dout;    

                if (enable = 1'b1) begin
                    next_state = s1;
                end
                else begin
                    next_state = idle;
                end
                end

            default: begin
                sel <= slave_sel;
                haddr <= haddr;
                hwrite <= hwrite;
                hburst <=  hburst;
                hready <= 1'b0;
                hwdata <= hwdata;
                dout <= dout; 

                next_state = idle;
            end
        endcase
    end
endmodule