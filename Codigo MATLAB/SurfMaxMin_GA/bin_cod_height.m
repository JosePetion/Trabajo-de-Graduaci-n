function bin_cod = bin_cod_height(press, low, high)
    bin_cod = ceil(log2( (high - low) * 10^press ));
end