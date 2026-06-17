module top_module(
            input            clk    ,
            input  [2:0]     y      ,
            input            x      ,
            output           Y0     ,
            output           z
);

            parameter        A = 3'b000                              ;
            parameter        B = 3'b001                              ;
            parameter        C = 3'b010                              ;
            parameter        D = 3'b011                              ;
            parameter        E = 3'b100                              ;

            reg     [2:0]    Next_state                              ;

            always @(*) begin
                             case(y)
                                          A : Next_state = x ? B : A ;
                                          B : Next_state = x ? E : B ;
                                          C : Next_state = x ? B : C ;
                                          D : Next_state = x ? C : B ;
                                          E : Next_state = x ? E : D ;
                                    default : Next_state = A         ;
                             endcase
            end

            assign Y0 = Next_state[0]                                ;
            assign z  = (y == D) || (y == E)                         ;

endmodule
            
