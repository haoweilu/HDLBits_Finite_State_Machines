module top_module(
        input  [6:1]        y    ,
        input               w    ,
        output              Y2   ,
        output              Y4
);

        parameter           A = 6'b000_001                           ;
        parameter           B = 6'b000_010                           ;
        parameter           C = 6'b000_100                           ;
        parameter           D = 6'b001_000                           ;
        parameter           E = 6'b010_000                           ;
        parameter           F = 6'b100_000                           ;

        reg     [6:1]       Next_state                               ;

        always @(*) begin
                         casex(y)
                                 6'bxxx_xx1 : Next_state = w ? A : B ;
                                 6'bxxx_x10 : Next_state = w ? D : C ;
                                 6'bxxx_100 : Next_state = w ? D : E ;
                                 6'bxx1_000 : Next_state = w ? A : F ;
                                 6'bx10_000 : Next_state = w ? D : E ;
                                 6'b100_000 : Next_state = w ? D : C ;
                                    default : Next_state = A         ;
                         endcase
        end

        assign Y2 = Next_state[2]                                    ;
        assign Y4 = Next_state[4]                                    ;

endmodule
