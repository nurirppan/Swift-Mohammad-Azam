import UIKit

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

struct Post: Decodable {
    let title: String
}

// MARK: - CARA JAMA DULU
func getPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(.badUrl))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        
        guard let data = data, error == nil else {
            completion(.failure(.noData))
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        completion(.success(posts ?? []))
        
    }.resume()
    
}

// MARK: - CARA TERBARU MENGGUNAKAN ASYNC FUNCTION
func getPosts() async throws -> [Post] {
    
    return try await withCheckedThrowingContinuation { continuation in
        getPosts { result in
            switch result {
                case .success(let posts):
                    continuation.resume(returning: posts)
                case .failure(let error):
                    continuation.resume(throwing: error)
            }
        }
    }
    
}

async {
    do {
        let posts = try await getPosts()
        print(posts)
    } catch {
        print(error)
    }
}


/**
 1
 - apa itu continuation : untuk export fungsi kita dimana menggunakan callback biasa namun sekarang menggunakan async yang terdapat di feature
 - withCheckedThrowingContinuation : ini adalah beberapa hal yang lain dari continuation yang dimana akan memberikan titik penangguhan
 - fungsi tersebut akan di tangguhkan, dan kemudian akan dipanggil kembali jika datanya sudah tersedia dengan menggunakan fungsi continuation.resume
 - jika kita tidak menggunakan continuation.resume, makan fungsi kita tidak akan pernah kembali / di return dari tangguhan
 -
 
 2
 
 */




