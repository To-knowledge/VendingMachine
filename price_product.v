module price_product (
	input [3:0] product_i,
	output	[3:0] price_o	
);

	reg [3:0] price_r;

	assign price_o = price_r;

	always@(product_i) begin
		case (product_i)
			4'b0001:
				price_r = 4'b0010;
			4'b0010:
				price_r = 4'b0101;
			4'b0100:
				price_r = 4'b0111;
			4'b1000:
				price_r = 4'b1010;
			default:
				price_r = 4'b0000;
		endcase
	end
endmodule