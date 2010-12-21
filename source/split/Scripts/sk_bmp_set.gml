//bmp set..

file_bin_write_byte(argument0, 66)
file_bin_write_byte(argument0, 77)

var skv_su;
skv_su=0

if sk_modulus(argument1, 2)>0
{
while(sk_modulus(argument1+54+skv_su, 4)>0){skv_su+=1}
}
else
{
while(sk_modulus(argument1+skv_su, 4)>0){skv_su+=1}
}

stres=sk_hex_conversion(argument1*argument2*3+54+(skv_su*argument2))
while(string_length(stres)!=8){stres="0"+stres}

file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 7, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 5, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 3, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 1, 2)))

file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 54)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 40)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)

stres=sk_hex_conversion(argument1)
while(string_length(stres)!=8){stres="0"+stres}

file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 7, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 5, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 3, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 1, 2)))

stres=sk_hex_conversion(argument2)
while(string_length(stres)!=8){stres="0"+stres}

file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 7, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 5, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 3, 2)))
file_bin_write_byte(argument0, sk_dec_conversion(string_copy(stres, 1, 2)))

file_bin_write_byte(argument0, 1)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 24)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)
file_bin_write_byte(argument0, 0)

return skv_su

// sk_bmp_set(열린BMP뼈대, 가로, 세로)
