module top_module(
        input            clk    ,
        input            areset ,
        input            x      ,
        output           z
);

        parameter        A = 2'b00                                        ;
        parameter        B = 2'b01                                        ;
        parameter        C = 2'b10                                        ;

        reg       [1:0] Cur_state                                         ;
        reg       [1:0] Next_state                                        ;

        always @(*) begin
                         case(Cur_state)
                                               A : Next_state = x ? B : A ;
                                               B : Next_state = x ? C : B ;
                                               C : Next_state = x ? C : B ;
                                         default : Next_state = A         ;
                         endcase
        end

        always @(posedge clk or posedge areset) begin
               if (areset)                           begin
                          Cur_state <= A                                  ;
               end
               else                                  begin
                          Cur_state <= Next_state                         ;
               end
        end

        assign z = (Cur_state == B)                                       ;

endmodule
