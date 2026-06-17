module top_module(
        input             clk     ,
        input             aresetn ,
        input             x       ,
        output            z
);

        parameter         A = 2'b00                                ;
        parameter         B = 2'b01                                ;
        parameter         C = 2'b10                                ;
        parameter         D = 2'b11                                ;

        reg    [1:0]      Cur_state                                ;
        reg    [1:0]      Next_state                               ;

        always @(*) begin
                         case(Cur_state)
                                        A : Next_state = x ? B : A ;
                                        B : Next_state = x ? B : C ;
                                        C : Next_state = x ? D : A ;
                                        D : Next_state = x ? B : C ;
                         endcase
        end

        always @(posedge clk or negedge aresetn) begin
               if (!aresetn)                          begin
                            Cur_state <= A                         ;
               end
               else                                   begin
                            Cur_state <= Next_state                ;
               end
        end 

        assign z = (Next_state == D)                               ;

endmodule
