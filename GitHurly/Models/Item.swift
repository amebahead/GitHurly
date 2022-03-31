//
//  Item.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import Foundation

struct Item: Codable {
    let id: Int     // Id
    let name: String        // Repository 이름
    let owner: Owner        // Author 정보
    let description: String     // 설명
    let stargazers_count: Int       // star 수
    let language: String        // 언어
}
