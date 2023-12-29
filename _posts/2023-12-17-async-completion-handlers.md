How to make async wrappers for code that uses completionHandlers

From https://www.hackingwithswift.com/quick-start/concurrency/how-to-use-continuations-to-convert-completion-handlers-into-async-functions:

```
struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

func fetchMessages(completion: @escaping ([Message]) -> Void) {
    let url = URL(string: "https://hws.dev/user-messages.json")!

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                completion(messages)
                return
            }
        }

        completion([])
    }.resume()
}

func fetchMessages() async -> [Message] {
    await withCheckedContinuation { continuation in
        fetchMessages { messages in
            continuation.resume(returning: messages)
        }
    }
}

let messages = await fetchMessages()
print("Downloaded \(messages.count) messages.")
```
