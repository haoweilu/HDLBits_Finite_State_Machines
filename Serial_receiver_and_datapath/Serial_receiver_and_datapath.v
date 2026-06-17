module top_module(
    input clk,
    input in,
    input reset,  
    output [7:0] out_byte,
    output done
); 


        parameter        idle   =  3'b000                                                              ;
        parameter        start  =  3'b001                                                              ;
        parameter        data   =  3'b010                                                              ;
        parameter        stop   =  3'b011                                                              ;
        parameter        error  =  3'b100                                                              ;

        reg  [2:0]       Cur_state                                                                     ;
        reg  [2:0]       Next_state                                                                    ;
 
        reg  [2:0]       cnt                                                                           ;

        always @(*) begin
                         case(Cur_state)
                                         idle : Next_state = in ? idle : start                         ;
                                         start: Next_state = data                                      ;
                                         data : Next_state = (cnt == 3'd7) ? (in ? stop : error) :data ;
                                         stop : Next_state = in ? idle : start                         ;
                                         error: Next_state = in ? idle : error                         ;
                         endcase
        end

        always @(posedge clk) begin
                  if (reset)                               begin
                        Cur_state <= idle                                                              ; 
                  end
                  else                                     begin
                        Cur_state <= Next_state                                                        ;
                  end
        end

        always @(posedge clk) begin
                  if (reset)                               begin
                        cnt <= 3'd0                                                                    ;
                  end
                  else if (Cur_state == data)              begin
                        cnt <= cnt + 3'd1                                                              ;
                  end
                  else                                     begin
                        cnt <= 3'd0                                                                    ;
                  end
        end
		
        always @(posedge clk) begin
                  if (reset)                               begin
        	        out_byte <= 8'b0                                                               ;
                  end
                  else if(Cur_state == start)              begin
                        out_byte[0] <= in                                                              ; 
                  end 
                  else if (Cur_state == data && cnt <3'd7) begin
                        out_byte[cnt+1'b1] <= in                                                          ;
                  end
        end
    	
        assign done = (Cur_state == stop)                                                              ;


    

endmodule

