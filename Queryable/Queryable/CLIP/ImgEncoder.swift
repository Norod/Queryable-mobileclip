//
//  ImgEncoder.swift
//  TestEncoder
//
//  Created by Ke Fang on 2022/12/08.
//

import Foundation
import CoreML
import UIKit

public struct ImgEncoder {
    var model: MLModel
    
    init(resourcesAt baseURL: URL,
         configuration config: MLModelConfiguration = .init()
    ) throws {
        config.computeUnits = .all
        let imgEncoderModel = try ImageEncoder_mobileclip_s0(configuration: config)
        self.model = imgEncoderModel.model
        print("Image encoder computeUnits = \(self.model.configuration.computeUnits)")
    }
    
    public func computeImgEmbedding(img: UIImage) async throws -> MLShapedArray<Float32> {
        let imgEmbedding = try await self.encode(image: img)
        return imgEmbedding
    }
    
//    public init(model: MLModel) {
//        self.model = model
//    }
    
    /// Prediction queue
    let queue = DispatchQueue(label: "imgencoder.predict")
    
    private func encode(image: UIImage) async throws -> MLShapedArray<Float32> {
        try autoreleasepool {
            do {
                guard let resizedImage = try image.resizeImageTo(size:CGSize(width: 256, height: 256)) else {
                    throw ImageEncodingError.resizeError
                }
                
                guard let buffer = resizedImage.convertToBuffer() else {
                    throw ImageEncodingError.bufferConversionError
                }
                
                guard let inputFeatures = try? MLDictionaryFeatureProvider(dictionary: ["colorImage": buffer]) else {
                    throw ImageEncodingError.featureProviderError
                }
                
                let result = queue.sync { autoreleasepool { try? model.prediction(from: inputFeatures) }}
                guard let embeddingFeature = result?.featureValue(for: "embOutput"),
                      let multiArray = embeddingFeature.multiArrayValue else {
                    throw ImageEncodingError.predictionError
                }
                return MLShapedArray<Float32>(converting: multiArray)
            } catch {
                print("Error in encoding: \(error)")
                throw error
            }
        }
    }
}

// Define the custom errors
enum ImageEncodingError: Error {
    case resizeError
    case bufferConversionError
    case featureProviderError
    case predictionError
}
