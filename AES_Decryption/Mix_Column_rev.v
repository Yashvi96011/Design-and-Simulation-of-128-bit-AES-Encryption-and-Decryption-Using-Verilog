module Inverse_Mix_column (
    input  [127:0] shift,
    output [127:0] mix
);

    // multiply by 2 (xtime)
    function [7:0] mul2;
        input [7:0] in;
        begin
            if (in[7] == 1'b0)
                mul2 = in << 1;
            else
                mul2 = (in << 1) ^ 8'h1b;
        end
    endfunction

    function [7:0] mul4;
        input [7:0] in;
        begin
            mul4 = mul2(mul2(in));
        end
    endfunction

    function [7:0] mul8;
        input [7:0] in;
        begin
            mul8 = mul2(mul4(in));
        end
    endfunction

    function [7:0] mul9;
        input [7:0] in;
        begin
            mul9 = mul8(in) ^ in;
        end
    endfunction

    function [7:0] mul11;
        input [7:0] in;
        begin
            mul11 = mul8(in) ^ mul2(in) ^ in;
        end
    endfunction

    function [7:0] mul13;
        input [7:0] in;
        begin
            mul13 = mul8(in) ^ mul4(in) ^ in;
        end
    endfunction

    function [7:0] mul14;
        input [7:0] in;
        begin
            mul14 = mul8(in) ^ mul4(in) ^ mul2(in);
        end
    endfunction

    // COLUMN 0
    assign mix[127:120] = mul14(shift[127:120]) ^ mul11(shift[119:112]) ^
                          mul13(shift[111:104]) ^ mul9(shift[103:96]);

    assign mix[119:112] = mul9(shift[127:120])  ^ mul14(shift[119:112]) ^
                          mul11(shift[111:104]) ^ mul13(shift[103:96]);

    assign mix[111:104] = mul13(shift[127:120]) ^ mul9(shift[119:112]) ^
                          mul14(shift[111:104]) ^ mul11(shift[103:96]);

    assign mix[103:96]  = mul11(shift[127:120]) ^ mul13(shift[119:112]) ^
                          mul9(shift[111:104])  ^ mul14(shift[103:96]);

    // COLUMN 1
    assign mix[95:88]  = mul14(shift[95:88]) ^ mul11(shift[87:80]) ^
                         mul13(shift[79:72]) ^ mul9(shift[71:64]);

    assign mix[87:80]  = mul9(shift[95:88])  ^ mul14(shift[87:80]) ^
                         mul11(shift[79:72]) ^ mul13(shift[71:64]);

    assign mix[79:72]  = mul13(shift[95:88]) ^ mul9(shift[87:80]) ^
                         mul14(shift[79:72]) ^ mul11(shift[71:64]);

    assign mix[71:64]  = mul11(shift[95:88]) ^ mul13(shift[87:80]) ^
                         mul9(shift[79:72])  ^ mul14(shift[71:64]);

    // COLUMN 2
    assign mix[63:56]  = mul14(shift[63:56]) ^ mul11(shift[55:48]) ^
                         mul13(shift[47:40]) ^ mul9(shift[39:32]);

    assign mix[55:48]  = mul9(shift[63:56])  ^ mul14(shift[55:48]) ^
                         mul11(shift[47:40]) ^ mul13(shift[39:32]);

    assign mix[47:40]  = mul13(shift[63:56]) ^ mul9(shift[55:48]) ^
                         mul14(shift[47:40]) ^ mul11(shift[39:32]);

    assign mix[39:32]  = mul11(shift[63:56]) ^ mul13(shift[55:48]) ^
                         mul9(shift[47:40])  ^ mul14(shift[39:32]);

    // COLUMN 3
    assign mix[31:24]  = mul14(shift[31:24]) ^ mul11(shift[23:16]) ^
                         mul13(shift[15:8])  ^ mul9(shift[7:0]);

    assign mix[23:16]  = mul9(shift[31:24])  ^ mul14(shift[23:16]) ^
                         mul11(shift[15:8])  ^ mul13(shift[7:0]);

    assign mix[15:8]   = mul13(shift[31:24]) ^ mul9(shift[23:16]) ^
                         mul14(shift[15:8])  ^ mul11(shift[7:0]);

    assign mix[7:0]    = mul11(shift[31:24]) ^ mul13(shift[23:16]) ^
                         mul9(shift[15:8])   ^ mul14(shift[7:0]);

endmodule
