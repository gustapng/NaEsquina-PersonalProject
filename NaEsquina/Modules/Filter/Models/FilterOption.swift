//
//  FilterOption.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 25/10/24.
//

struct FilterOption {
    let name: String
    var isActive: Bool
}

var filters: [FilterOption] = [
    FilterOption(name: "Mercado", isActive: true),
    FilterOption(name: "Farmácia", isActive: false),
    FilterOption(name: "Padaria", isActive: true),
    FilterOption(name: "Hamburgueria", isActive: true),
    FilterOption(name: "Pizzaria", isActive: false)
]
