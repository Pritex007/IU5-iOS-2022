//
//  SequenceСreator.swift
//  LABS
//
//  Created by Ilya Murashko on 14.02.2022.
//

import Foundation

// ‼️ Все вычисления производить внутри функций ‼️

final class SequenceСreator {
    
    // Функция получает на вход целое число N
    // и возвращает массив целых чисел от 1 до N.
    // Если N меньше единицы, то функция должна вернуть пустой массив.
    // Пример:
    // на вход подаем: 5
    // на выходе получаем: [1,2,3,4,5]
    // ================================
    // на вход подаем: -99
    // на выходе получаем: []
    
    static func createSequenceFromZeroTo(finalElement: Int) -> [Int] {
        
        var sequence: [Int] = []
        if (finalElement > 0){
        for i in 0..<finalElement {
            sequence.append(i + 1)
            }
        }
        return sequence
}
    
    // Функция получает на вход целое число N
    // и возвращает массив целых чисел от N до 1.
    // Если N меньше единицы, то функция должна вернуть пустой массив.
    // Пример:
    // на вход подаем - 5
    // на выходе получаем - [5,4,3,2,1]
    // ================================
    // на вход подаем - 0
    // на выходе получаем - []
    
    static func createReversedSequenceToZeroFrom(finalElement: Int) -> [Int] {
        
        guard finalElement > 0 else {
            return []
        }
        
        var sequence : [Int] = []
        
        for i in 0..<finalElement {
            sequence.append(finalElement - i)
        }
        return sequence
    }
}
