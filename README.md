# Queryable-MC [ML-MobileClip fork]


This is a fork of [Queryable](https://github.com/mazzzystar/Queryable), an iOS app, which leverages the Apple's [ml-mobileclip](https://github.com/apple/ml-mobileclip) model to conduct offline searches in the 'Photos' album. Unlike the category-based search model built into the iOS Photos app, Queryable allows you to use natural language statements, such as `a brown dog sitting on a bench`, to search your album. Since it's offline, your album privacy won't be compromised by any company, including Apple or Google.

## How does it work?
* Encode all album photos using the ml-mobileclip Image Encoder, compute image vectors, and save them.
* For each new text query, compute the corresponding text vector using the Text Encoder.
* Compare the similarity between this text vector and each image vector.
* Rank and return the top K most similar results.

## Run on Xcode
You need to put the precompiled .mlpackage files (folder packages) under the folder `Queryable/Queryable/put_models_here`

To get them, go to a folder where you put your projects and do
```bash
git clone https://huggingface.co/Norod78/CoreML-MobileCLIP-S0
```
Then copy ```ImageEncoder_mobileclip_s0.mlpackage``` and ```TextEncoder_mobileclip_s0.mlpackage``` from the folder CoreML-MobileCLIP-S0 to `Queryable/Queryable/put_models_here`

## Core ML Export
If you wish to export from pytorch yourself (e.g do some model quantization/acceleration work), here is [A reference notbook I've prepared for converting Apple's S0 weights to CoreML](https://github.com/Norod/Queryable-mobileclip/blob/main/PyTorch2CoreML-mobileclip.ipynb)
> 
## Original Queryable License
MIT License

Copyright (c) 2023 Ke Fang

## ML-MobileClip Port
By [Doron Adler](https://linktr.ee/Norod78)
