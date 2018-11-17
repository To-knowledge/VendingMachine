module VendingMachine(
		input clk_i,
		input  rst_i,
		//------选择商品类型------
		input [3:0] product_type_i,
		//------是否重新选择------
		input reselected_i,
		//------投币金额------
		input num_twenty_i,
		input num_ten_i,
		input [1:0]num_five_i,
		input [3:0] num_one_i,
		//------是否输出商品------
		output out_o,
		//------找零对应1，5，10元的数目------
		output ten_num_o,
		output [1:0] five_num_o,
		output [2:0] one_num_o,
		output [1:0] Current_state_o
);
		reg out_r;

		assign out_o = out_r;
		
		assign Current_state_o = Current_state;
		
		reg [1:0] Current_state;
		reg [1:0] Next_state;
		
		wire [4:0] money_buffer;
		wire [4:0] Selected_product_price;
				
		wire succ_or_fail;
		
		wire finish_moneying;
		
		assign finish_moneying = (money_buffer == 0)? 0 : 1;
		
		reg [3:0] product_type_r;
		reg [4:0] money_buffer_r;
		
		//定义所有状态
		parameter [1:0] S0 = 2'b00;
		parameter [1:0] S1 = 2'b01;
		parameter [1:0] S2 = 2'b10;
		parameter [1:0] S3 = 2'b11;
		
		//状态机转移模块 
		always@(posedge clk_i)
		begin
				if(!rst_i)
				begin
						Current_state = S0;
					end
				else
						Current_state = Next_state;
		end
		
		//状态转移驱动模块
		
		always@(posedge clk_i)
		begin
				case(Current_state)
					S0:
						begin
							money_buffer_r = 5'b0;
							product_type_r = product_type_i;
							if(product_type_i == 4'b0)
										Next_state = S0;
							else
										Next_state = S1;
						end
					S1:
						begin
							if(reselected_i == 1'b1)
										Next_state = S0;
							else
								begin 
										if(finish_moneying == 1'b1)
										begin
												Next_state = S2;
												money_buffer_r = money_buffer;
										end
								end
						end
					S2: 
					begin
							if(succ_or_fail == 1'b1)
								Next_state = S3;
							else
								Next_state = S0;
					end
					S3:
					begin
								Next_state = S0;
					end

					default: 
								Next_state = S0;
				endcase
		end
		
		//状态机输出模块
		
		always@(posedge clk_i)
		begin
				if(!rst_i)
						out_r = 1'b0;
				else begin
										case(Current_state)
												S0,S1,S2:
															out_r = 1'b0;
												S3:
															out_r = 1'b1;
												default:
															;
										endcase
								end
		end

		
		//价格映射模块
		price_product U1(
							.product_i(product_type_r),
							.price_o(Selected_product_price)
		);
		
		//投币模块
		putting_money V1(
							.num_one_i(num_one_i),
							.num_five_i(num_five_i),
							.num_ten_i(num_ten_i),
							.num_twenty_i(num_twenty_i),
							.money_buffer_o(money_buffer)
		);
		
		//清算模块
		processing W1(
							.price_i(Selected_product_price),
							.money_buffer_i(money_buffer_r),
							.temp_o(succ_or_fail)
		);
		//找零模块 
		change X1(
							.price_i(Selected_product_price),
							.money_buffer_i(money_buffer_r),
							.type_one_o(one_num_o),
							.type_five_o(five_num_o),
							.type_ten_o(ten_num_o)
		);
		
endmodule