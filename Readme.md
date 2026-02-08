# Compressing DNAbin Objects in ape

This is experimental code to develop compression of "DNAbin" objects for *ape*.

The objective is to be able to decrease significantly the quantity of memory needed to store DNA sequences while permitting all analyses possible with "DNAbin" objects. It is expected that these analyses will run significantly faster with the compressed data.

The file `code.R` contains experimental code to (un)compress the data, with some examples. So far, the Hamming distances can be computed with the compressed data exactly in the same way than with the original data.
