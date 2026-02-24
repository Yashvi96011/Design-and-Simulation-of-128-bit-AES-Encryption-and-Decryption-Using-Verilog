module AES_Encrypt (
    input  [127:0] plaintext,
    input  [127:0] key,
    output [127:0] ciphertext
);

    wire [1407:0] round_keys;

    wire [127:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10;
    wire [127:0] sb1,sr1,mc1;
    wire [127:0] sb2,sr2,mc2;
    wire [127:0] sb3,sr3,mc3;
    wire [127:0] sb4,sr4,mc4;
    wire [127:0] sb5,sr5,mc5;
    wire [127:0] sb6,sr6,mc6;
    wire [127:0] sb7,sr7,mc7;
    wire [127:0] sb8,sr8,mc8;
    wire [127:0] sb9,sr9,mc9;
    wire [127:0] sb10,sr10;

    //  KEY EXPANSION
    key_expansion KE (
        .key_in(key),
        .key_out(round_keys)
    );

    //  ROUND 0 
    add_round_key ARK0 (
        .state_in(plaintext),
        .round_key(round_keys[0 +: 128]),   // Round 0
        .state_out(s0)
    );

    //  ROUND 1 
    sub_byte SB1 (s0, sb1);
    Row_shfting SR1 (sb1, sr1);
    mix_column MC1 (sr1, mc1);
    add_round_key ARK1 (mc1, round_keys[128 +: 128], s1);

    // ROUND 2
    sub_byte SB2 (s1, sb2);
    Row_shfting SR2 (sb2, sr2);
    mix_column MC2 (sr2, mc2);
    add_round_key ARK2 (mc2, round_keys[256 +: 128], s2);

    //  ROUND 3 
    sub_byte SB3 (s2, sb3);
    Row_shfting SR3 (sb3, sr3);
    mix_column MC3 (sr3, mc3);
    add_round_key ARK3 (mc3, round_keys[384 +: 128], s3);

    //  ROUND 4 
    sub_byte SB4 (s3, sb4);
    Row_shfting SR4 (sb4, sr4);
    mix_column MC4 (sr4, mc4);
    add_round_key ARK4 (mc4, round_keys[512 +: 128], s4);

    //  ROUND 5 
    sub_byte SB5 (s4, sb5);
    Row_shfting SR5 (sb5, sr5);
    mix_column MC5 (sr5, mc5);
    add_round_key ARK5 (mc5, round_keys[640 +: 128], s5);

    // ROUND 6 
    sub_byte SB6 (s5, sb6);
    Row_shfting SR6 (sb6, sr6);
    mix_column MC6 (sr6, mc6);
    add_round_key ARK6 (mc6, round_keys[768 +: 128], s6);

    // ROUND 7 
    sub_byte SB7 (s6, sb7);
    Row_shfting SR7 (sb7, sr7);
    mix_column MC7 (sr7, mc7);
    add_round_key ARK7 (mc7, round_keys[896 +: 128], s7);

    //  ROUND 8
    sub_byte SB8 (s7, sb8);
    Row_shfting SR8 (sb8, sr8);
    mix_column MC8 (sr8, mc8);
    add_round_key ARK8 (mc8, round_keys[1024 +: 128], s8);

    // ROUND 9 
    sub_byte SB9 (s8, sb9);
    Row_shfting SR9 (sb9, sr9);
    mix_column MC9 (sr9, mc9);
    add_round_key ARK9 (mc9, round_keys[1152 +: 128], s9);

    // FINAL ROUND 
    sub_byte SB10 (s9, sb10);
    Row_shfting SR10 (sb10, sr10);
    add_round_key ARK10 (sr10, round_keys[1280 +: 128], s10);

    assign ciphertext = s10;

endmodule
