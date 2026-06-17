module top_module(
        input            clk    ,
        input            reset  ,
        input            x      ,
        output           z
);

        parameter        A = 3'b000                                          ;
        parameter        B = 3'b001                                          ;
        parameter        C = 3'b010                                          ;
        parameter        D = 3'b011                                          ;
        parameter        E = 3'b100                                          ;

        reg       [2:0]  Cur_state                                           ;
        reg       [2:0]  Next_state                                          ;

        always @(*) begin
                                   case(Cur_state)
                                                  A : Next_state = x ? B : A ;
                                                  B : Next_state = x ? E : B ;
                                                  C : Next_state = x ? B : C ;
                                                  D : Next_state = x ? C : B ;
                                                  E : Next_state = x ? E : D ;
                                            default : Next_state = A         ;
                                   endcase
        end

        always @(posedge clk) begin
               if (reset)          begin
                         Cur_state <= A                                      ;
               end
               else                begin
                         Cur_state <= Next_state                             ;
               end
        end

        assign z = (Cur_state == D) || (Cur_state == E)                      ;

endmodule
