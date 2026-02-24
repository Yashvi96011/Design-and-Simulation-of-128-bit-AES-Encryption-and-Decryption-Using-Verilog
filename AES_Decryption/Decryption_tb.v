`timescale 1ns/1ps

module AES_tb;

    reg  [127:0] ciphertext;
    reg  [127:0] key;

    wire [127:0] plaintext;

    // Instantiate AES Decryption
    AES_Decrypt DEC (
        .ciphertext (ciphertext),
        .key        (key),
        .plaintext  (plaintext)
    );

    initial begin
        // Standard AES-128 test vector
        //ciphertext = 128'h2eeeb095fc339504b08ddc94e489dcca;
        ciphertext = 128'h743567d70c67b778b8a961bd3e8706dc;
        key        = 128'h000102030405060708090a0b0c0d0e0f;

        #10;

       
        $display("CIPHERTEXT : %h", ciphertext);
        $display("KEY        : %h", key);
        $display("PLAINTEXT  : %h", plaintext);
        

        #10;
        $stop;
    end

endmodule
