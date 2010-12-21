if argument1=0 or argument1=1
{
file_bin_write_byte(argument0, argument1)
}
else
{
file_bin_write_byte(argument0, 255-argument1+2)
}
