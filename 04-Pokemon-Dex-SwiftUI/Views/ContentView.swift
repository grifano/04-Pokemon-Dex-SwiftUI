//
//  ContentView.swift
//  04-Pokemon-Dex-SwiftUI
//
//  Created by sorlenko on 04/08/2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokedex: FetchedResults<Pokemon>
    
    let fetcher = FetchService()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pokedex) { pokemon in
                    NavigationLink(value: pokemon) {
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        
                        VStack(alignment: .leading) {
                            Text(pokemon.name!)
                                .font(.system(size: 22, weight: .bold))
                            HStack {
                                ForEach(pokemon.types!, id: \.self) { type in
                                    PillTagView(for: type)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokemon")
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                Text(pokemon.name ?? "no name")
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add Item", systemImage: "plus") {
                        getPokemon()
                    }
                }
            }
        }
    }
    
    private func getPokemon() {
        Task {
            for id in 1..<152 {
                do {
                    let fetchedPokemon = try await fetcher.fetchPokemon(id)
                    let pokemonDB = Pokemon(context: viewContext)
                    pokemonDB.id = fetchedPokemon.id
                    pokemonDB.name = fetchedPokemon.name
                    pokemonDB.types = fetchedPokemon.types
                    pokemonDB.hp = fetchedPokemon.hp
                    pokemonDB.attack = fetchedPokemon.attack
                    pokemonDB.defense = fetchedPokemon.defense
                    pokemonDB.specialAttack = fetchedPokemon.specialAttack
                    pokemonDB.specialDefense = fetchedPokemon.specialDefense
                    pokemonDB.speed = fetchedPokemon.speed
                    pokemonDB.shiny = fetchedPokemon.shiny
                    pokemonDB.sprite = fetchedPokemon.sprite
                    
                    try viewContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
