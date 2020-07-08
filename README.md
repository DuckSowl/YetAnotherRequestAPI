# YetAnotherRequestAPI
It's just a little studying project

## Installation

 `XCode -> File -> Swift Packages -> Add Package Dependency`   
 Then add `https://github.com/DuckSowl/YetAnotherRequestAPI` as package repository and choose `master` branch

## Usage

 Import library: `import Request`
 Now just make your requests
 
```
let url = URL(string: "https://www.example.com")!
Request(url: url, httpMethod: .get, headers: ["Header": "value"],
        parameters: [URLQueryItem(name: "do", value: "something")])
    .response() {
        switch $0 {
        case .success(let data):
            process(data)
        case .failure(let error):
            print(error)
        }
    }
```

Or even simplier

```
Request.get(string: "https://www.example.com")
       .response(completion: { print($0) })
```
