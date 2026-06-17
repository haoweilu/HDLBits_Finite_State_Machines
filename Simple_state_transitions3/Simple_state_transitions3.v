module top_module(
        input             in        ,
        input  [1:0]      state     ,
        input  [1:0]      next_state,
        output            out
);

        parameter         A = 2'b00                    ;
        parameter         B = 2'b01                    ;
        parameter         C = 2'b10                    ;
        parameter         D = 2'b11                    ;


        always @(*) begin
               case (state)
                           A : next_state = in ? B : A ;
                           B : next_state = in ? B : C ;
                           C : next_state = in ? D : A ;
                           D : next_state = in ? B : C ;
               endcase
        end

        assign out = (state == D)                      ;

endmodule
