//pnt를 로드

var filessed;

filessed=file_bin_open(argument0, 0)

for(i=0; i!=file_bin_size(filessed)/4; i+=1){rgb[i]=""}

for(i=0; i!=file_bin_size(filessed)/4; i+=1)
{
rgb[i]+=sk_hex_conversion(file_bin_read_byte(filessed))
rgb[i]+=sk_hex_conversion(file_bin_read_byte(filessed))
rgb[i]+=sk_hex_conversion(file_bin_read_byte(filessed))
file_bin_read_byte(filessed)
}

file_bin_close(filessed)

// sk_pnt_load(pnt파일)
