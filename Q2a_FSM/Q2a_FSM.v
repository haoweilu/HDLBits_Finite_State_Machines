module top_module(
        input            clk    ,
        input            reset  ,
        input            w      ,
        output           z
);

        parameter        A = 3'b000                                               ;
        parameter        B = 3'b001                                               ;
        parameter        C = 3'b010                                               ;
        parameter        D = 3'b011                                               ;
        parameter        E = 3'b100                                               ;
        parameter        F = 3'b101                                               ;

        reg  [3:1]       Cur_state                                                ;
        reg  [3:1]       Next_state                                               ;

        always @(*)          begin
                                  case(Cur_state)
                                                       A : Next_state = w ? B : A ;
                                                       B : Next_state = w ? C : D ;
                                                       C : Next_state = w ? E : D ;
                                                       D : Next_state = w ? F : A ;
                                                       E : Next_state = w ? E : D ;
                                                       F : Next_state = w ? C : D ;
                                                 default : Next_state = A         ; 
                                  endcase
        end

        always @(posedge clk) begin
               if (reset)          begin
                         Cur_state <= A                                           ;
               end
               else                begin
                         Cur_state <= Next_state                                  ;
               end
        end

        assign z = (Cur_state == E) || (Cur_state == F)                           ;

endmodule
