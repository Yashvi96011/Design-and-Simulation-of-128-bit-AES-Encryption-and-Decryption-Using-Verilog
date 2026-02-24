module Row_shfting (
    input  [127:0] rows,
    output [127:0] shifted_rows
);

    // Row 0 (no shift)
    assign shifted_rows[127:120] = rows[127:120];
    assign shifted_rows[95:88]   = rows[95:88];
    assign shifted_rows[63:56]   = rows[63:56];
    assign shifted_rows[31:24]   = rows[31:24];

    // Row 1 (left shift by 1)
    assign shifted_rows[119:112] = rows[87:80];
    assign shifted_rows[87:80]   = rows[55:48];
    assign shifted_rows[55:48]   = rows[23:16];
    assign shifted_rows[23:16]   = rows[119:112];

    // Row 2 (left shift by 2)
    assign shifted_rows[111:104] = rows[47:40];
    assign shifted_rows[79:72]   = rows[15:8];
    assign shifted_rows[47:40]   = rows[111:104];
    assign shifted_rows[15:8]    = rows[79:72];

    // Row 3 (left shift by 3)
    assign shifted_rows[103:96]  = rows[7:0];
    assign shifted_rows[71:64]   = rows[103:96];
    assign shifted_rows[39:32]   = rows[71:64];
    assign shifted_rows[7:0]     = rows[39:32];

endmodule
