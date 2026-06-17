module top_module(
        input            clk    ,
        input            in     ,
        input            reset  ,
        output           out
);

        parameter        A = 2'b00  ;
        parameter        B = 2'b01  ;
        parameter        C = 2'b10  ;
        parameter        D = 2'b11  ;

        reg [1:0]        Cur_state  ;
        reg [1:0]        Next_state ;

        always @(*) begin
                          case(Cur_state)
                                         A : Next_state = in ? B : A ;
                                         B : Next_state = in ? B : C ;
                                         C : Next_state = in ? D : A ;
                                         D : Next_state = in ? B : C ;
                          endcase
        end

        always @(posedge clk)                   begin
               if (reset)                             begin
                                 Cur_state <= A                      ;
               end
               else                                   begin
                                 Cur_state <= Next_state             ;
               end
        end

        assign out = (Cur_state == D )                               ;

endmodule
