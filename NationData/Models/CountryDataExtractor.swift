//
//  CountryDataExtractor.swift
//  NationData
//
//  Created by Christopher Inegbedion on 26/08/2024.
//


import Foundation
import OpenAIKit

struct ExtractedData {
    let countryName: String
    let countryCode: String
    let dataPoints: [String]
    let dataPointCodes: [String]
    let years: [String]
}

func extractData(from prompt: String, completion: @escaping (ExtractedData?) -> Void) async {
    let openAI = OpenAI(Configuration(organizationId: "", apiKey: ProcessInfo.processInfo.environment["openai-key"] ?? ""))
    
    do {
        let functions: [Function] = [
            Function(
                name: "getCountryDataPoint",
                description: "Get the data point for a country",
                parameters: Parameters(
                    type: "object",
                    properties: [
                        "countryName": ParameterDetail(
                            type: "string",
                            description: "The name of the country, e.g. Albania, Nigeria, Japan"
                        ),
                        "countryCode": ParameterDetail(type: "string", description: "A World-Bank data API valid country code, e.g. UK, USA, NG"),
                        "dataPoints": ParameterDetail(
                            type: "string", description: "The data point requested. Comma-deliniated, e.g. 'gdp', 'inflation', etc"
                        ),
                        "dataPointCodes": ParameterDetail(type: "string", description: "The World-Bank data API valid data point codes, e.g. SI.POV.GINI"),
                        "years": ParameterDetail(type: "string", description: "The years requested. Comma-deliniated, e.g 2020, 2021, 2022, etc")
                    ],
                    required: ["countryName", "countryCode", "dataPoints", "dataPointCodes", "years"]
                )
            )
        ]
        
        let messages: [ChatMessage] = [
            ChatMessage(role: .user, content: prompt)
        ]
        
        let chatParameters = ChatParameters(
            model: .gpt4,
            messages: messages,
            functionCall: "auto",
            functions: functions
        )
        
        let chatCompletion = try await openAI.generateChatCompletion(
            parameters: chatParameters
        )
        
        if let message = chatCompletion.choices[0].message, let functionCall = message.functionCall {
            let jsonString = functionCall.arguments
            if let data = jsonString.data(using: .utf8) {
                do {
                    if
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                        let countryName = json["countryName"] as? String,
                        let countryCode = json["countryCode"] as? String,
                        let dp = json["dataPoints"] as? String,
                        let dpc = json["dataPointCodes"] as? String,
                        let k = json["years"] as? String
                    {
                    // Separate each item by their commas and convert Substring to String
                    let dataPoints = dp.split(separator: ",").map { String($0) }
                    let dataPointCodes = dpc.split(separator: ",").map { String($0) }
                    let years = k.split(separator: ",").map { String($0) }
                    
                    completion(.init(countryName: countryName, countryCode: countryCode, dataPoints: dataPoints, dataPointCodes: dataPointCodes, years: years))
                    }
                } catch {
                    // Insert your own error handling method here.
                }
            }
        }
        
    } catch (let e) {
        print(e)
        completion(nil)  // Handle error by returning nil
    }
}
