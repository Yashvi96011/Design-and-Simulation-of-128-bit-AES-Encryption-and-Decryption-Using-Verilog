`timescale 1ns/1ps

module encrypt_tb;

    reg  [127:0] plaintext;
    reg  [127:0] key;

    wire [127:0] ciphertext;

    // Instantiate AES Encryption
    AES_Encrypt ENC (
        .plaintext  (plaintext),
        .key        (key),
        .ciphertext (ciphertext)
    );

    initial begin
        // Standard AES-128 test vector
        plaintext = 128'h00112233445566778899aabbccddeeff;
        // plaintext =128'h3925841d02dc09fbdc118597196a0b32;
        key       = 128'h000102030405060708090a0b0c0d0e0f;

        #10;

      
        $display("PLAINTEXT  : %h", plaintext);
        $display("KEY        : %h", key);
        $display("CIPHERTEXT : %h", ciphertext);
        

        #10;
        $stop;
    end

endmodule
