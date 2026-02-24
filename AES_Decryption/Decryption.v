
module AES_Decrypt (
    input  [127:0] ciphertext,
    input  [127:0] key,
    output [127:0] plaintext
);

    wire [1407:0] round_keys;

    wire [127:0] s10,s9,s8,s7,s6,s5,s4,s3,s2,s1,s0;

    wire [127:0] isr1,isb1,imc1;
    wire [127:0] isr2,isb2,imc2;
    wire [127:0] isr3,isb3,imc3;
    wire [127:0] isr4,isb4,imc4;
    wire [127:0] isr5,isb5,imc5;
    wire [127:0] isr6,isb6,imc6;
    wire [127:0] isr7,isb7,imc7;
    wire [127:0] isr8,isb8,imc8;
    wire [127:0] isr9,isb9,imc9;
    wire [127:0] isr10,isb10;

    // KEY EXPANSION 
    key_expansion KE (
        .key_in(key),
        .key_out(round_keys)   
    );

    // INITIAL ROUND 
    // Start with Round 10 key
    add_round_key ARK10 (
        .state_in(ciphertext),
        .round_key(round_keys[1280 +: 128]),
        .state_out(s10)
    );

    // ROUND 9 
    Inverse_Row_shfting ISR9 (s10, isr9);
    inv_sub_byte ISB9 (isr9, isb9);
    add_round_key ARK9 (isb9, round_keys[1152 +: 128], imc9);
    Inverse_Mix_column IMC9 (imc9, s9);

    // ROUND 8 
    Inverse_Row_shfting ISR8 (s9, isr8);
    inv_sub_byte ISB8 (isr8, isb8);
    add_round_key ARK8 (isb8, round_keys[1024 +: 128], imc8);
    Inverse_Mix_column IMC8 (imc8, s8);

    //  ROUND 7 
    Inverse_Row_shfting ISR7 (s8, isr7);
    inv_sub_byte ISB7 (isr7, isb7);
    add_round_key ARK7 (isb7, round_keys[896 +: 128], imc7);
    Inverse_Mix_column IMC7 (imc7, s7);

    //  ROUND 6 
    Inverse_Row_shfting ISR6 (s7, isr6);
    inv_sub_byte ISB6 (isr6, isb6);
    add_round_key ARK6 (isb6, round_keys[768 +: 128], imc6);
    Inverse_Mix_column IMC6 (imc6, s6);

    // ROUND 5
    Inverse_Row_shfting ISR5 (s6, isr5);
    inv_sub_byte ISB5 (isr5, isb5);
    add_round_key ARK5 (isb5, round_keys[640 +: 128], imc5);
    Inverse_Mix_column IMC5 (imc5, s5);

    //ROUND 4 
    Inverse_Row_shfting ISR4 (s5, isr4);
    inv_sub_byte ISB4 (isr4, isb4);
    add_round_key ARK4 (isb4, round_keys[512 +: 128], imc4);
    Inverse_Mix_column IMC4 (imc4, s4);

    //  ROUND 3 
    Inverse_Row_shfting ISR3 (s4, isr3);
    inv_sub_byte ISB3 (isr3, isb3);
    add_round_key ARK3 (isb3, round_keys[384 +: 128], imc3);
    Inverse_Mix_column IMC3 (imc3, s3);

    //  ROUND 2 
    Inverse_Row_shfting ISR2 (s3, isr2);
    inv_sub_byte ISB2 (isr2, isb2);
    add_round_key ARK2 (isb2, round_keys[256 +: 128], imc2);
    Inverse_Mix_column IMC2 (imc2, s2);

    //  ROUND 1 
    Inverse_Row_shfting ISR1 (s2, isr1);
    inv_sub_byte ISB1 (isr1, isb1);
    add_round_key ARK1 (isb1, round_keys[128 +: 128], imc1);
    Inverse_Mix_column IMC1 (imc1, s1);

    // FINAL ROUND 
    Inverse_Row_shfting ISR0 (s1, isr10);
    inv_sub_byte ISB0 (isr10, isb10);
    add_round_key ARK0 (
        .state_in(isb10),
        .round_key(round_keys[0 +: 128]),
        .state_out(s0)
    );

    assign plaintext = s0;

endmodule
