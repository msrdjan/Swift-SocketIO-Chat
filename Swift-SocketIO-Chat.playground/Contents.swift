//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

import SocketIO

var socket = SocketIOClient(socketURL: URL(string: "https://chat.rbt.rs/chat")!, config: [.nsp("/chat"), .log(true), .forcePolling(true)])

socket.on("connect") {data, ack in
    print("connect")
    
    socket.emitWithAck("joined", ["name": "Swift", "room": "test_room"]).timingOut(after: 0) {data in
        socket.emit("text", ["msg": "Hello from Swift!!!"])
    }
}

socket.on("joined") {data, ack in
    print("joined", data)
}

socket.on("error") {data, ack in
    print("error", data)
}

socket.on("text") {data, ack in
    print("text", data)
}

socket.connect()
