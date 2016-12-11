# (down)Sampler for CSV files [![Build Status](https://travis-ci.org/raviolicode/downsampler.svg?branch=master)](https://travis-ci.org/raviolicode/downsampler) | [![Coverage Status](https://coveralls.io/repos/github/raviolicode/downsampler/badge.svg?branch=master)](https://coveralls.io/github/raviolicode/downsampler?branch=master)

![Downsampling kittens](http://cs.brown.edu/courses/cs143/proj1/cat_hybrid_image_scales.jpg)

[Downsampling](https://en.wikipedia.org/wiki/Decimation_(signal_processing)) is originally used in signal or image processing.


## Description

This gem is a minimal CLI example that reads a file containing one numeric value per line, and produces a new, shorter file. The output summarizes the original data, according to different sampling strategies, and number of samples required. 


```bash
sampler input.csv output.csv
sampler input.csv output.csv --samples 365
sampler input.csv output.csv --samples 365 --sample-by peak
```

Output of `sampler -h`:

```
Options:
  [--samples=N]            # desired NUMBER of data-points to be in the output file
  [--sample-by=SAMPLE_BY]  # strategy on how data is downsampled
                           # Default: peak
                           # Possible values: peak, sum

Usage: sampling INPUT_FILE OUTPUT_FILE [--samples NUMBER]
```

## Installation

```bash
gem build sampler.gemspec
gem install sampler
```

## Tests

Tests are made with Rspec and Aruba. Just run them with:

```
bundle
bundle exec rake spec
```

## Benchmarking

> “Premature optimization is the root of all evil.” (Hoare, Knuth.)

TBD.
