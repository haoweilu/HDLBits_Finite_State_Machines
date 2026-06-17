module top_module(
        input            clk       ,
        input  [7:0]     in        ,
        input            reset     ,
        output [23:0]    out_bytes ,
        output           done
);

        parameter        byte1   = 2'b00                                                     ;
        parameter        byte2   = 2'b01                                                     ;
        parameter        byte3   = 2'b10                                                     ;
        parameter        stop    = 2'b11                                                     ;

        reg    [1:0]     Cur_state                                                           ;
        reg    [1:0]     Next_state                                                          ;

        always @(*) begin  
                                   case(Cur_state)
                                                  byte1 : Next_state = in[3] ? byte2 : byte1 ;
                                                  byte2 : Next_state = byte3                 ;
                                                  byte3 : Next_state = stop                  ;
                                                  stop  : Next_state = in[3] ? byte2 : byte1 ;
                                   endcase
        end

        always @(posedge clk) begin
               if (reset)          begin
                         Cur_state <= byte1                                                  ;
               end
               else                begin
                         Cur_state <= Next_state                                             ;
               end
        end

       always @(posedge clk) begin
                                   case(Cur_state)
                                                  byte1 : out_bytes[23:16] <= in[7:0]        ;
                                                  byte2 : out_bytes[15:8]  <= in[7:0]        ;
                                                  byte3 : out_bytes[7:0]   <= in[7:0]        ;
                                                  stop  : out_bytes[23:16] <= in[7:0]        ;
                                   endcase
       end

       assign done = (Cur_state == stop)                                                     ;

endmodule
