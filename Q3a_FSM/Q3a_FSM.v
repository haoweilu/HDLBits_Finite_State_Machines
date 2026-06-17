module top_module(
        input             clk    ,
        input             reset  ,
        input             s      ,
        input             w      ,
        output            z
);

        parameter A = 2'b00                                                                          ;
        parameter B = 2'b01                                                                          ;
        parameter C = 2'b10                                                                          ;
        parameter D = 2'b11                                                                          ;

        reg  [1:0]        Cur_state                                                                  ;
        reg  [1:0]        Next_state                                                                 ;
   
        reg  [1:0]        w_cnt                                                                      ;

        always @(*)                     begin
                                                          case(Cur_state)
                                                                          A : Next_state = s ? B : A ;
                                                                          B : Next_state = C         ;
                                                                          C : Next_state = D         ;
                                                                          D : Next_state = B         ;
                                                          endcase
        end

        always @(posedge clk)           begin
               if (reset)                                 begin
                         Cur_state <= A                                                              ;
               end
               else                                       begin
                         Cur_state <= Next_state                                                     ;
               end
        end

        always @(posedge clk)           begin
               if (reset)                                 begin
                          w_cnt <= 2'd0                                                              ;
               end 
               else if (Cur_state == B)                   begin
                         if (w == 1'b1)                        begin
                                      w_cnt <= 2'd1                                                  ;
                         end
                         else                                  begin
                                      w_cnt <= 2'd0                                                  ;
                         end
               end
               else if (Cur_state == C || Cur_state == D) begin 
                          if (w == 1'b1)                       begin
                                       w_cnt <= w_cnt + 2'd1                                         ;
                          end
                          else                                 begin
                                       w_cnt <= w_cnt                                                ;
                          end
               end
        end

        assign z = (Cur_state == B) && (w_cnt == 2'd2)                                               ;

endmodule
