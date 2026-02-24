module mix_column (
    input  [127:0] shift,
    output [127:0] mix
);

    // Multiply by 02 in GF(2^8)
    function [7:0] mul2;
        input [7:0] in;
        begin
            if (in[7] == 1'b0)                 //  check MSB
                mul2 = {in[6:0], 1'b0};
            else
                mul2 = {in[6:0], 1'b0} ^ 8'h1b;
        end
    endfunction

    // Multiply by 03 = (02 × in) ⊕ in
    function [7:0] mul3;
        input [7:0] in;
        begin
            mul3 = mul2(in) ^ in;
        end
    endfunction

    // COLUMN 0
    assign mix[127:120] = mul2(shift[127:120]) ^ mul3(shift[119:112]) ^
                           shift[111:104]     ^ shift[103:96];

    assign mix[119:112] = shift[127:120]       ^ mul2(shift[119:112]) ^
                           mul3(shift[111:104]) ^ shift[103:96];

    assign mix[111:104] = shift[127:120]       ^ shift[119:112] ^
                           mul2(shift[111:104]) ^ mul3(shift[103:96]);

    assign mix[103:96]  = mul3(shift[127:120]) ^ shift[119:112] ^
                           shift[111:104]     ^ mul2(shift[103:96]);

    // COLUMN 1
    assign mix[95:88] = mul2(shift[95:88]) ^ mul3(shift[87:80]) ^
                        shift[79:72]      ^ shift[71:64];

    assign mix[87:80] = shift[95:88]       ^ mul2(shift[87:80]) ^
                        mul3(shift[79:72]) ^ shift[71:64];

    assign mix[79:72] = shift[95:88]       ^ shift[87:80] ^
                        mul2(shift[79:72]) ^ mul3(shift[71:64]);

    assign mix[71:64] = mul3(shift[95:88]) ^ shift[87:80] ^
                        shift[79:72]      ^ mul2(shift[71:64]);

    // COLUMN 2
    assign mix[63:56] = mul2(shift[63:56]) ^ mul3(shift[55:48]) ^
                        shift[47:40]      ^ shift[39:32];

    assign mix[55:48] = shift[63:56]       ^ mul2(shift[55:48]) ^
                        mul3(shift[47:40]) ^ shift[39:32];

    assign mix[47:40] = shift[63:56]       ^ shift[55:48] ^
                        mul2(shift[47:40]) ^ mul3(shift[39:32]);

    assign mix[39:32] = mul3(shift[63:56]) ^ shift[55:48] ^
                        shift[47:40]      ^ mul2(shift[39:32]);

    // COLUMN 3
    assign mix[31:24] = mul2(shift[31:24]) ^ mul3(shift[23:16]) ^
                        shift[15:8]       ^ shift[7:0];

    assign mix[23:16] = shift[31:24]       ^ mul2(shift[23:16]) ^
                        mul3(shift[15:8]) ^ shift[7:0];

    assign mix[15:8]  = shift[31:24]       ^ shift[23:16] ^
                        mul2(shift[15:8]) ^ mul3(shift[7:0]);

    assign mix[7:0]   = mul3(shift[31:24]) ^ shift[23:16] ^
                        shift[15:8]       ^ mul2(shift[7:0]);

endmodule
