//
//  TMI.swift
//  TMI
//
//  Created by Jason on 2021/11/09.
//

import Foundation
import UIKit

struct TMI {
    var topic : String
    var emoji : String
    var title : String
    var description : String
    var writer : User
}

var NOW_LOGIN = User()

var topics = ["생활","유머","커피","술","음식","영화","음악","캐릭터","여행","IT"]

var haneul = User(id: "skyduck2u", profileImg: "", name: "정하늘", age: 29, job: "CEO", contact: "01012345678")

var wonhee = User(id: "WONHEE", profileImg: "", name: "장원희", age: 29, job: "CTO", contact: "01012345678")

var TMI_1 = TMI(topic: "1", emoji: "🍕", title: "1", description: "하와이안 피자는 캐나다에서 만들어졌다", writer: haneul)
var TMI_2 = TMI(topic: "2", emoji: "🫐", title: "2", description: "블루베리 속살은 연두색이다", writer: haneul)
var TMI_3 = TMI(topic: "3", emoji: "🥲", title: "3", description: "스타벅스 라떼에 우유를 두유로바꾸면 바닐라시럽이 무료다", writer: haneul)
var TMI_4 = TMI(topic: "4", emoji: "🐶", title: "4", description: "스누피는 키티와 경쟁하기 위해 나온 캐릭터다", writer: haneul)
var TMI_5 = TMI(topic: "5", emoji: "💵", title: "5", description: "스우파 제트썬 주거래은행은 농협이다", writer: haneul)

var TMI_6 = TMI(topic: "6", emoji: "💚", title: "6", description: "녹차아이스크림 색소는 누에똥으로 만든다", writer: wonhee)
var TMI_7 = TMI(topic: "7", emoji: "🥃", title: "7", description: "트럼프는 가족력으로 술을 아예 안 마신다", writer: wonhee)
var TMI_8 = TMI(topic: "8", emoji: "🪳", title: "8", description: "바퀴벌레는 사람과 닿으면 하루종일 자기 몸을 닦는다", writer: wonhee)
var TMI_9 = TMI(topic: "9", emoji: "🪳", title: "9", description: "라쿠카라차~ 는 스페인어로 바퀴벌레다", writer: wonhee)
var TMI_10 = TMI(topic: "10", emoji: "🦜", title: "10", description: "남의 앵무새에게 욕을 가르치면 재물손괴죄이다", writer: wonhee)

var TMIList : [TMI] = [TMI_1,TMI_2,TMI_3,TMI_4,TMI_5,TMI_6,TMI_7,TMI_8,TMI_9,TMI_10]
