//
//  File.swift
//  ConnectOng
//
//  Created by Alley Pereira on 26/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

struct File {
    
    //MARK: Atributos do meu arquivo
    let ext: String // extensao do arqv
    let name: String // nome do arqv
//    let content: Data // conteudo do arquivo
    let folderName: String? // pasta do arqv
    
    var fullname: String {
        return name + "." + ext // nome do arqv
    }
    
    var filePath: String {
        let documentsURL: URL = FileManager.default.urls(for: .documentDirectory,
                                                         in: .userDomainMask).first! // diretorio padrao
        let documentsPath: String = documentsURL.relativePath // versao string de url do caminho de documentos
        
        if let folder = folderName {
            return "\(documentsPath)/\(folder)/\(fullname)"
        } else {
            return "\(documentsPath)/\(fullname)"
        }
    }
    
    var fileUrl: URL {
        return URL(fileURLWithPath: filePath)
    }
    
    //MARK: Metodos do meu arquivo
    func create(content: Data) {
        FileManager.default.createFile(atPath: self.filePath, contents: content, attributes: nil)
    }
    
    func read() -> Data? {
        return try? Data(contentsOf: self.fileUrl)
    }
    
//    func update() {
//        create(content: )
//    }
//
//    func delete() {
//
//    }
}
