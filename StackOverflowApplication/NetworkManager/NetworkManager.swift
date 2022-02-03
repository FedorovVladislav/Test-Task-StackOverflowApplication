//
//  NetworkManager.swift
//  StackOverflowApplication
//
//  Created by Елизавета Федорова on 28.01.2022.
//

import Foundation

enum ManagerErrors: Int, Error {
    
    case invalidReciveData
    case invalidUrl
    case invalidResponseCode
    case invalidParseJson
    case invalidResponse
    case invalidImage

    var descriptoin : String {
        switch self {
        case .invalidReciveData:
            return "Error recive data"
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Indalid Response"
        case .invalidParseJson:
            return "Error parse data"
        case .invalidResponseCode:
            return "CodeNot 200"
        case .invalidImage:
            return "Cant make Image"
        }
    }
    
}


class NetworkManager {
    
    private func executeRequestWithJSon < T:Codable > (url: URL , completionHandler: @escaping ((T?, Error?)-> Void)) {
    
    let request = createRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, responce, error in
        
        if let error = error {
            completionHandler(nil,error)
            return
        }
        
        guard let httpResponse = responce as? HTTPURLResponse else {
            completionHandler(nil,ManagerErrors.invalidResponse)
            return
        }
        //проверяем какой код нам пришел
        if httpResponse.statusCode >= 300 {
            completionHandler(nil, ManagerErrors.invalidResponseCode)
            return
        }
        
        guard let data = data else {
            completionHandler(nil, ManagerErrors.invalidReciveData)
            return
        }
        //парсим данные
        if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
            print("Parse data ")
            sleep(3)
            DispatchQueue.main.async {
                completionHandler(decodedResponse, nil)
            }
        } else {
            completionHandler(nil,ManagerErrors.invalidParseJson)
        }
        
        }.resume()
}

    private func createRequest (url: URL) -> URLRequest{
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Safari/605.1.15"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        return request as URLRequest
    }
    
}

extension NetworkManager {
    
    typealias ArticlesCompletionClosure = ((QuestionsList?, Error?) -> Void)

    func fetchQuestionList(tag: DataTag, completion: @escaping ArticlesCompletionClosure) {
    
        guard  let url = URL(string: StackOverFlowAPI.setUrl(tag: tag)) else {
            completion(nil, ManagerErrors.invalidUrl)
            return
        }
        
    executeRequestWithJSon(url: url, completionHandler: completion)
    }
}

extension NetworkManager {
    
    typealias AnswerCompletionClosure = ((AnswerData?, Error?) -> Void)

    func fetchAnsList(question id: Int, completion: @escaping AnswerCompletionClosure) {
        print( StackOverFlowAPI.setUrl(question: id))
        guard  let url = URL(string: StackOverFlowAPI.setUrl(question: id)) else {
            completion (nil, ManagerErrors.invalidUrl)
            return
        }
        
    executeRequestWithJSon(url: url, completionHandler: completion)
    }
}

