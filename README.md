# Queryable [ML-MobileClip fork]


The open-source code of this for of [Queryable](https://github.com/mazzzystar/Queryable), an iOS app, leverages the Apple's [ml-mobileclip](https://github.com/apple/ml-mobileclip) model to conduct offline searches in the 'Photos' album. Unlike the category-based search model built into the iOS Photos app, Queryable allows you to use natural language statements, such as `a brown dog sitting on a bench`, to search your album. Since it's offline, your album privacy won't be compromised by any company, including Apple or Google.

## How does it work?
* Encode all album photos using the ml-mobileclip Image Encoder, compute image vectors, and save them.
* For each new text query, compute the corresponding text vector using the Text Encoder.
* Compare the similarity between this text vector and each image vector.
* Rank and return the top K most similar results.

## Run on Xcode
Download the `ImageEncoder_float32.mlmodelc` and `TextEncoder_float32.mlmodelc` from [Google Drive](https://drive.google.com/drive/folders/1b-Km1Q8Osuco_NKdC5PPyddEhilz9mpT?usp=drive_link).
Clone this repo, put the downloaded models below `CoreMLModels/` path and run Xcode, it should work.

## Core ML Export
> If you only want to run Queryable, you can **skip this step** and directly use the exported model from [Google Drive](https://drive.google.com/drive/folders/1b-Km1Q8Osuco_NKdC5PPyddEhilz9mpT?usp=drive_link). If you wish to implement Queryable that supports your own native language, or do some model quantization/acceleration work, here is [The notbook I've prepared for converting Apple's S0 weights to CoreML](https://github.com/Norod/Queryable-mobileclip/blob/main/PyTorch2CoreML-mobileclip.ipynb)
> 
## Original Queryable License
MIT License

Copyright (c) 2023 Ke Fang

## ML-MobileClip Porte
By [Doron Adler](https://linktr.ee/Norod78)
